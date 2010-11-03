From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] submodule: preserve all arguments exactly when
 recursing
Date: Wed, 3 Nov 2010 00:30:19 -0500
Message-ID: <20101103053019.GC10631@burratino>
References: <1288758882-77286-1-git-send-email-kevin@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Wed Nov 03 06:30:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDVvl-0005Vy-IX
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 06:30:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443Ab0KCFai (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 01:30:38 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:37602 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751929Ab0KCFag (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Nov 2010 01:30:36 -0400
Received: by yxk8 with SMTP id 8so202714yxk.19
        for <git@vger.kernel.org>; Tue, 02 Nov 2010 22:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5W8UBBlfV2/XheLHhNUpLN5ZkOGuWnJ8DpoB6mtNM84=;
        b=KCW8N798wERl6nwzePa/dtr3XQBg2TO1eJ4z+djAanJvW/4ebNK3/lR7ZgyEnNND2M
         JnkslHyQ+sSwFcmvy6rbySTjounOHM61t3QMhBwdh3Fb9OIXrLG79bPElN41qGjUaieH
         DZuGmjg4MoDkUeVhcygvro/yFmGeysBZiONyE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=JB8lJWN6KE9Ra14mnMu+Y4lrdTXsmRJCL5QObUXOuP9FktweNGOxo5dFUrFWtd0J9X
         RpINZIuchJk6JbVxTZh/M32FYv+1R7RUzvDE9k/4CHyhjsDF0bRdIxajDTVyNFkuyVNY
         GcX3NyWppjZYFmbLArjmp2BuGEs6PcWmBM3Yk=
Received: by 10.151.15.10 with SMTP id s10mr535055ybi.218.1288762236154;
        Tue, 02 Nov 2010 22:30:36 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id m25sm6906211yha.43.2010.11.02.22.30.34
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 02 Nov 2010 22:30:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1288758882-77286-1-git-send-email-kevin@sb.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160580>

Kevin Ballard wrote:

> I tried to write tests for this, but there are only two ways to get args
> with spaces to be accepted and passed to the recursive invocation.
> The first is via the --reference flag, but I don't think it really makes
> sense to use that flag in connection with --recursive and was not comfortable
> using it in a test.

Could you explain this further?  I think --reference pointing to a
repository with objects shared by multiple (sub)projects makes a lot
of sense.
