From: A Large Angry SCM <gitzilla@gmail.com>
Subject: Re: Git files data formats documentation
Date: Sat, 05 Aug 2006 14:56:42 -0700
Message-ID: <44D5141A.2070004@gmail.com>
References: <44D42F0D.3040707@gmail.com> <7vac6jfzem.fsf@assigned-by-dhcp.cox.net>
Reply-To: gitzilla@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sat Aug 05 23:57:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9U8d-0007c6-Er
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 23:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932529AbWHEV4q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 17:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbWHEV4q
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 17:56:46 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:50380 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932529AbWHEV4q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 17:56:46 -0400
Received: by py-out-1112.google.com with SMTP id z74so752103pyg
        for <git@vger.kernel.org>; Sat, 05 Aug 2006 14:56:45 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:disposition-notification-to:date:from:reply-to:user-agent:x-accept-language:mime-version:to:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=AhvLAK86r87mL4SCs4E+zW84a2aeYMsXW0SzFNiCkwzz9ktTQfM5Gf04erLO6CrqsKlMmOPeP++dAVPeHWA0QLpXfAvaXpu1gqKf1B7uzjAaa59QB9uaLamfXuNObSlECW5qXF4/FvgBE/jY0YJkbHP+3ROH3zBEk959oEVy3Tg=
Received: by 10.35.51.13 with SMTP id d13mr8286899pyk;
        Sat, 05 Aug 2006 14:56:45 -0700 (PDT)
Received: from ?10.0.0.6? ( [70.32.187.210])
        by mx.gmail.com with ESMTP id k13sm1943390pyf.2006.08.05.14.56.43;
        Sat, 05 Aug 2006 14:56:44 -0700 (PDT)
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
In-Reply-To: <7vac6jfzem.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24937>

Junio C Hamano wrote:
...
>> <OCTAL_MODE>
>> 	# Octal encoding, without prefix, of the file system object
>> 	# type and permission bits. The bit layout is according to the
>> 	# POSIX standard, with only regular files, directories, and
>> 	# symbolic links permitted. The actual permission bits are
>> 	# all zero except for regular files. The only permission bit
>> 	# of any consequence to Git is the owner executable bit. By
>> 	# default, the permission bits for files will be either 0644
>> 	# or 0755, depending on the owner executable bit.
>> 	;
> 
> It's not really "by default" -- more like "by definition", since
> there is no way for the program to use something different.  We
> used to record non-canonical modes in ancient versions of git,
> but I think fsck-objects would warn on objects created that way.
> 

See git-mktree.
