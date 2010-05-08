From: Andreas Hartmetz <ahartmetz@gmail.com>
Subject: Re: git branch documentation improvements
Date: Sat, 8 May 2010 18:39:37 +0200
Message-ID: <201005081839.37790.ahartmetz@gmail.com>
References: <201005070024.41172.ahartmetz@gmail.com> <4BE3BF2F.8050903@viscovery.net>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 08 18:39:47 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAn46-0002Eh-V4
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 18:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006Ab0EHQjk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 12:39:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:20748 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753435Ab0EHQjj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 12:39:39 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1090750fga.1
        for <git@vger.kernel.org>; Sat, 08 May 2010 09:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=hp1+geKr2sXFO+SO5Jk1PGRx/NkVMWOGsi3IIYzzVlc=;
        b=slq+7XwtlXLyOwzGjomMyE8c5CM95r/koSlgKh9MSCmlnujcpx7/v6kxCDUKBomshl
         usg2TTkjv4tdPOtpVWjhzqSqH5d+xE0GiZOGPH+N025HFtNA5RKzNAsORvJedbQo/Nld
         1t5JiaBf18NpSXy1w/82WQ1oufWLXoIYX0PQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=Wik8Cb+VzLdqkM4aWnmLweO6OF9jye9dFYKhS5kTryRDiKHS6ZMFgWMetvPBjIhHPn
         u7YdPbhlWILErvnkpztNGcqXI1yTTaZNlnTKt85mTGOmuULPQTFmjCerBQB2an6YcFQ9
         0Mdo+l6oXxsCR00cN2Eva7GPahk7mjNX6Nz40=
Received: by 10.87.13.6 with SMTP id q6mr6169431fgi.19.1273336778009;
        Sat, 08 May 2010 09:39:38 -0700 (PDT)
Received: from rechenplan.localnet (brln-4dbc2129.pool.mediaWays.net [77.188.33.41])
        by mx.google.com with ESMTPS id 19sm6369847fkr.9.2010.05.08.09.39.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 May 2010 09:39:37 -0700 (PDT)
User-Agent: KMail/1.13.3 (Linux/2.6.33-02063303-generic; KDE/4.4.75; x86_64; svn-1124099; 2010-05-04)
In-Reply-To: <4BE3BF2F.8050903@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146664>

On Friday 07 May 2010 09:20:15 Johannes Sixt wrote:
> Am 5/7/2010 0:24, schrieb Andreas Hartmetz:
> > The most significant change is renaming <start-point> (or is it
> > <startpoint>...) to <branch-head> because even I as a relative beginner
> > know that a branch is defined by its (movable) head, and <start-point>
> > *does* actually specify the new branch head if I'm not mistaken.
> 
> But what is wrong with "start-point"? It precisely conveys the meaning of
> the parameter.
> 
Look at -f: as far as I understand it moves the branch *head*, so start-point 
is plain wrong. The "root" of the branch is not moved, or only moved 
indirectly (not sure if the latter is allowed).
