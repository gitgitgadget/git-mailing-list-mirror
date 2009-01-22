From: Jonathan del Strother <maillist@steelskies.com>
Subject: Re: Merging adjacent deleted lines?
Date: Thu, 22 Jan 2009 10:57:41 +0000
Message-ID: <57518fd10901220257p62b6d1efof97ba3fcf90dbfda@mail.gmail.com>
References: <57518fd10901211120n62f8d0e9ya8595fc9baa6476c@mail.gmail.com>
	 <7vy6x4cqq1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Jan 22 11:59:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPxHD-0005Bs-LG
	for gcvg-git-2@gmane.org; Thu, 22 Jan 2009 11:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817AbZAVK5o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2009 05:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752318AbZAVK5n
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Jan 2009 05:57:43 -0500
Received: from fg-out-1718.google.com ([72.14.220.152]:47712 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbZAVK5n (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2009 05:57:43 -0500
Received: by fg-out-1718.google.com with SMTP id 19so2120390fgg.17
        for <git@vger.kernel.org>; Thu, 22 Jan 2009 02:57:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=kkwYK8Z7qu9bRNDYm6fSim2Zka7rK3v3BusepZuKF6I=;
        b=kkIgnspWjS4Zat4WV+9ASmuuofD3nzzcYdJBkrQgrIxd3mrvSLW0kPljQ9uEFfriSy
         XFq6WQ0Ea8WT+qR93hZyR27QQz1JnHvIUt+tamdOBgW9AbLky9pVeWSN+tBeF4dcdlk8
         HthR333oahhp2sYnXVVY69sAAMPgbA0L/NM6M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ouAgKqqvciqnb4J+BpqVEeFQZc1Ljqp6nYTcqMv7xZaBnab0FqP5d8IjUTbA/jK9aQ
         nrWaizLTAlRTCbCxBnRRQzMsCfq8V9bWm8IGhILHK0ywocgUZ/mX9CoPStJXxB02eM4+
         65yoiXXJDt/JExLvSYqu1Q0tu0xW6Aq0hFoS8=
Received: by 10.223.107.76 with SMTP id a12mr693347fap.29.1232621861314; Thu, 
	22 Jan 2009 02:57:41 -0800 (PST)
In-Reply-To: <7vy6x4cqq1.fsf@gitster.siamese.dyndns.org>
X-Google-Sender-Auth: 32b4ded4bbde88dd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106743>

On Wed, Jan 21, 2009 at 7:49 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> onsdag 21 januari 2009 20:20:50 skrev Jonathan del Strother:
> [...]
> I think you've illustrated a case for graphical merge resolution tools, i.e.
> run git mergetool to help resolve the conlicts. It will run a graphical tool
> for you.
>

Mmm.  I use opendiff, which is generally ok, but in this case produced
a merge looking like this :
http://pastie.org/paste/asset/367587/Picture_6.png
Which, in my mind, isn't any clearer about the fact that both lines
ought to be deleted than the text conflict markers are.  Do any of the
other graphical tools present conflicts like that differently?


On Wed, Jan 21, 2009 at 9:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> But that is only true if it is obvious to you.  When you cannot remember
> what each side did since they forked, there are two ways you can use to
> understand the history better without resorting to graphical merge tools.
>
>  $ git log -p --merge <path>
>

Ahh, that's very helpful - thanks.
