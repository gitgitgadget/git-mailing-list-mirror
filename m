From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Reachability lists in git
Date: Tue, 18 Nov 2014 12:27:37 -0800
Message-ID: <20141118202737.GL6527@google.com>
References: <Pine.LNX.4.44L0.1411181354320.4374-100000@iolanthe.rowland.org>
 <20141118194129.GI6527@google.com>
 <xmqqzjbouv0y.fsf@gitster.dls.corp.google.com>
 <20141118202250.GK6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Stern <stern@rowland.harvard.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 18 21:27:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XqpNH-00016u-3N
	for gcvg-git-2@plane.gmane.org; Tue, 18 Nov 2014 21:27:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755273AbaKRU1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Nov 2014 15:27:38 -0500
Received: from mail-ig0-f174.google.com ([209.85.213.174]:61225 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755256AbaKRU1h (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Nov 2014 15:27:37 -0500
Received: by mail-ig0-f174.google.com with SMTP id hn15so1690916igb.13
        for <git@vger.kernel.org>; Tue, 18 Nov 2014 12:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qxhqLmylvTvXV4NWPBzEMjHSxHP3zHR8hOPatj5XcVA=;
        b=Dl3Zwz3npQaJXflTcATDgk7+x2cglBA37PIFNhxLoe+4rEF3Aw8pNgKlPZI2brt8YS
         qpATgognAOAXFICdWtzhMmDWLxQC4wNgo8F0vh1FQkGg1XcQ4m6gGMIrfYU/iXh2+5m8
         Dhiz+aE9cDsIctJeGmwg71ieYdgU4mKS6kB4MAUljbuK1cY7RZPoiklax+ONOkIJcir1
         PIjmm77wH5wWG4ykZ9X4kZDCkepwaHLSwg7q4ZC6NaUESnUoax+UGe8lKuyqbce4TNGl
         J5Tw4RIEEUnhaAHXkz4WYhKQUzLuH1yp/EMnUSlkdQdkRvzJuomT01Sj0VBtG7jaS9Xv
         XsCA==
X-Received: by 10.107.168.216 with SMTP id e85mr2296319ioj.89.1416342456755;
        Tue, 18 Nov 2014 12:27:36 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:1d6d:1067:602d:d9c7])
        by mx.google.com with ESMTPSA id kb7sm8240361igb.16.2014.11.18.12.27.34
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Nov 2014 12:27:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20141118202250.GK6527@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:
> Junio C Hamano wrote:

>>      - Were there follow-up fixes and enhancements on the topic
>>        after the topic was merged to 'master' (this is harder)?
>
> There's only one line coming out of the-merge^2 in the ancestry-path
> graph, so there were no such follow-up fixes.

Or rather, there are two lines, but the second is just a merge of the
same topic to maint-1.8.1.

And here following the railroad tracks becomes tedious.  gitk has a
nicer interface for "list children" and "go to child".
