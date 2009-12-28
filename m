From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Newbie to git
Date: Sun, 27 Dec 2009 18:18:57 -0800
Message-ID: <7v8wcnx2lq.fsf@alter.siamese.dyndns.org>
References: <1435.87.196.47.196.1261932152.squirrel@webmail.decimal.pt>
 <3a9710ae6b01fabf3b462da607af2534@192.168.1.222>
 <26ae428a0912271212j70857e29m6248f6ec653f7551@mail.gmail.com>
 <0a78ff1d3ae5d236fa45c31f7bb8bd54@192.168.1.222>
 <m27hs8t5b7.fsf@whitebox.home>
 <ecddd9ed719d3d854b2248970cdb9cdf@192.168.1.222>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: <mysql.jorge@decimal.pt>
X-From: git-owner@vger.kernel.org Mon Dec 28 03:20:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NP5Dn-0005l7-9E
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 03:20:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbZL1CTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Dec 2009 21:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbZL1CTK
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Dec 2009 21:19:10 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbZL1CTJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Dec 2009 21:19:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B0CE1AAC8F;
	Sun, 27 Dec 2009 21:19:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8rj7+6RFeW4T3tE+vznryVBc2+s=; b=HYNbf9
	KeeZQEjMqRLjcSsEjYHS5wSe30TXFNqLGN7xMw+G5MECY+9AwiF0ylr5NJSyIKPA
	QsoNw8r1SlN2eOhD+P/8r23Vg0P4gKWmRTdOiZNSeS6FaUXzSlxYAEJEkRRy6Iaa
	fun8gflb2/crRyMeAbhjN47qP6k2QRR+eLcdM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Zkr+V4NgwA2GioSnO6EnZolNtyQqwyqs
	3KkNgT43Lsb1b1T69tSGzG7D82QAdqgI2Phy+fs2zXCLcEbAzE+Fh7geaZrIERep
	r5vgjEjZG7axKH21MuuY1Sn0d3gZCAAbZ5qumnGlxa0CfgKPvpWyCeK6OUHCzHv2
	Y+d8rxAauC4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8E951AAC89;
	Sun, 27 Dec 2009 21:19:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 80B2AAAC87; Sun, 27 Dec 2009
 21:18:59 -0500 (EST)
In-Reply-To: <ecddd9ed719d3d854b2248970cdb9cdf@192.168.1.222> (mysql jorge's
 message of "Sun\, 27 Dec 2009 23\:00\:04 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5D952A8A-F357-11DE-8485-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135721>

<mysql.jorge@decimal.pt> writes:

> Hi Andreas,

If you are addressing Andreas, why does your mail have:

    To: <git@vger.kernel.org>
    Cc: <git@vger.kernel.org>

and no other addressee???

> not i have:
> /home/apache/gitprojects/mydir.git
>
> created with: git init --base mydir.git
>
> Now, inside here, what should i do to create my projects:
>
> mkdir myproject1
> cd myproject1
> git init
> touch a.txt
> git add .
> git commit -m "1st commit"
>
> am i correct or not really?

You created "myproject1" somewhere you started "mkdir" in (perhaps in
$HOME?) [*1*] and that project tracks a single file "a.txt"; you are
correct if that was what you wanted to do.

The new repository "myproject1" doesn't have any relation to the bare
repository at /home/apache/gitprojects/mydir.git/ you created earlier.
The next steps I recommend new people are:

 (1) push into the public repository, by doing:

     cd myproject1
     git push /home/apache/gitprojects/mydir.git/ master

 (2) make sure push went correctly by trying to clone from there:

     cd ..
     mv myproject1 myproject1.old
     git clone /home/apache/gitprojects/mydir.git/ myproject1

 (3) check if the clone is what you expect

     diff myproject1.old/a.txt myproject1/a.txt

 (4) once satisfied, remove the old one

     rm -fr myproject1.old

And keep working in the myproject1 repository from there on.


[Footnote]

*1* If you started that "mkdir" somewhere else you may want to remove it
and redo that step, especially if you did so inside that bare repository
you created earlier, i.e. /home/apache/gitprojects/mydir.git directory.
You don't want to have it there.
