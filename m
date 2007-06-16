From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 11/11] Document git commit --untracked-files and --verbose
Date: Sun, 17 Jun 2007 00:29:51 +0200
Message-ID: <200706170029.52368.jnareb@gmail.com>
References: <11820206272990-git-send-email-jnareb@gmail.com> <11820206363507-git-send-email-jnareb@gmail.com> <7vr6ob3br0.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 17 01:47:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HzhzT-00057e-UV
	for gcvg-git@gmane.org; Sun, 17 Jun 2007 01:47:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754364AbXFPXra (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jun 2007 19:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754261AbXFPXra
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jun 2007 19:47:30 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:43786 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206AbXFPXr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jun 2007 19:47:29 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1669588mue
        for <git@vger.kernel.org>; Sat, 16 Jun 2007 16:47:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Gp75SRijhRm8LIB1W2beqT9th8tHlMhNfyjxzcch25Fh1wAmREhN4EZKWvAO/NbhOao2AWivCl3JCE5PAp6nypXE9bL8erkhezCYk96BbLuxxcdyYvXILcrfM38c3H+ZVhk+v+MAf1GvhGgpXG7tdSvqeFPIupNMRqYncOJqDMY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=LLGU07HprYssP6OcxB//hJE+JTXv25gkBIz6LSxUQzbc7jPMe73dMz6/ew52xWeN8DBnUMy0oHHZay51evU3JWA8c73/AHk4gsDDRbJ0HuM8FuUoE6or+xTN2Rfi0mwYht3ftM4hYLR4kKIEmc6f12Is3uQQ9KHmq2wRcLA7YPY=
Received: by 10.82.112.3 with SMTP id k3mr8547132buc.1182037647574;
        Sat, 16 Jun 2007 16:47:27 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id d24sm7293709nfh.2007.06.16.16.47.25
        (version=SSLv3 cipher=OTHER);
        Sat, 16 Jun 2007 16:47:26 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vr6ob3br0.fsf@assigned-by-dhcp.pobox.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50324>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> +-u|--untracked-files::
>> +	Show all untracked files, also those in uninteresting
>> +	directories.
>> +
>> +-v|--verbose::
>> +	Show the diff output between the HEAD commit and what
>> +	would be committed.
>> +
> 
> Thanks -- "show" sounds a bit funny, though, don't you think?

First, the description above has to be suitable both for git-commit and 
for git-status, as both commands share options. Nevertheless those 
options have slight different meaning: git-status print what is 
"shown", in git-commit what is "shown" appears in the editor as/in 
prepared commit message (printed using git-[run]status).

Second, this is last patch in the series... ;-)


Feel free to correct it if you have better idea for description of those 
options.

-- 
Jakub Narebski
Poland
