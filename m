From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] merge & sequencer: turn "Conflicts:" hint into a comment
Date: Mon, 27 Oct 2014 14:14:42 -0700
Message-ID: <20141027211441.GH5500@google.com>
References: <xmqq1tpxgw6t.fsf@gitster.dls.corp.google.com>
 <xmqqvbn9f9ig.fsf@gitster.dls.corp.google.com>
 <xmqqr3xxf9ey.fsf_-_@gitster.dls.corp.google.com>
 <20141026185909.GC18144@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 27 22:14:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xircq-0007Uy-3E
	for gcvg-git-2@plane.gmane.org; Mon, 27 Oct 2014 22:14:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbaJ0VOs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2014 17:14:48 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:53519 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752280AbaJ0VOr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2014 17:14:47 -0400
Received: by mail-pa0-f43.google.com with SMTP id eu11so6261604pac.2
        for <git@vger.kernel.org>; Mon, 27 Oct 2014 14:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=i3wj+huAPxegsBiCEMUE61HwK1+h3+roh02ETpCLK0A=;
        b=b0CX5qw0c/Ca4DC8WxNM3t8PH8lYVtwUfEF+AlQqR8sv2VNXdDLFOdHyjNDvzR6cM+
         5S60f9YBmugqFkIaEGz9i083MAXrXLXQA8wyb1Qy1YTY+B9sgP2uzvl+SoQ1/oFxJjlW
         gUhXIwddPyCCLwhSiSx3Lm0AmavDfy1xl970ff0J/pL4QDmusfE53XLoI0vIyxIg6asX
         JyfusLaJ7GLIjW5br+U4+3wBj0e/2K8flK1jithpYorpdls8wFKjNZYQMskPX2WDQ+Lr
         W8OdHpdaV6O9HS49ZwoqpQ3Ud5ZHz5OtVgbj+sXlEVDhMLRxVK2T283JWoY/gbqrhpjh
         HhcQ==
X-Received: by 10.68.225.131 with SMTP id rk3mr4392462pbc.157.1414444487341;
        Mon, 27 Oct 2014 14:14:47 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:e40f:656f:e2a1:93d7])
        by mx.google.com with ESMTPSA id ot8sm11686654pbc.1.2014.10.27.14.14.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Oct 2014 14:14:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141026185909.GC18144@peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> For the most part, combined-diff (and --cc) will show the interesting
> cases anyway. But if you take a whole file from one side of the merge,
> then there is nothing interesting for diff to show. Do people still want
> to get that more complete list of potentially interesting files? And if
> so, how do they do it?  I think there really isn't a great way besides
> repeating the merge.

If you have time to experiment with tr/remerge-diff from pu[1], that
would be welcome.

Maybe some day it can be the default behavior for 'log -p'.

> If that is the only casualty, I think it is probably a net-win.

Yes.

Thanks,
Jonathan

[1] http://thread.gmane.org/gmane.comp.version-control.git/256591
