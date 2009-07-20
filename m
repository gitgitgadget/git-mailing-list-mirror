From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] Add git svn gc command
Date: Mon, 20 Jul 2009 14:18:48 +0200
Message-ID: <9b18b3110907200518p57a8b3gdfb51004e274b2bc@mail.gmail.com>
References: <8E0EFA3B-E8C0-4030-8BAE-E8EF65694031@gmail.com>
	 <20090720083621.GA3237@dcvr.yhbt.net>
	 <9b18b3110907200202kbb78c8dm43e0451900e4f2fb@mail.gmail.com>
	 <200907201342.01912.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Robert Zeh <robert.a.zeh@gmail.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jul 20 14:18:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSrpZ-0002In-HG
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 14:18:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753514AbZGTMSv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Jul 2009 08:18:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753439AbZGTMSu
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 08:18:50 -0400
Received: from mail-yx0-f184.google.com ([209.85.210.184]:38291 "EHLO
	mail-yx0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753437AbZGTMSt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jul 2009 08:18:49 -0400
Received: by yxe14 with SMTP id 14so3553271yxe.33
        for <git@vger.kernel.org>; Mon, 20 Jul 2009 05:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8aijiJOP7rLPGqW4fphJnQaGrg+9u2YVZYpwaqIkBNc=;
        b=ldVdonCNHqnBqc6ebVP38My3EUekQUdQyC9YK0BD+I83XhsaNTOq+RAV7eQWGkFQbg
         6PwtbCJjWQfKuOOKuEbwZ4aYAEmKp5nGtXuP95+BHio8xdesMbuvsP5fFyKm5yWmAaZm
         8vFvXO6HT8oqXNgXJigQIMUYMgs2bLL/SYA14=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=SqhhluCwhezfNdxpTm4p7H3kVCjolzNzSsOOg/Tuvz+VuLF0sBD+jDsp13BIpRkSDJ
         dbvFauR9ZjH5QXAbZLy0mGKFfj2FLLzNRDz3A+b4+JXXSj9QnakMtVCoydqOeA//HV0M
         E5KMMpWGwEc5iKV08Ac5xEbIr14734X2y3zAQ=
Received: by 10.231.16.193 with SMTP id p1mr219125iba.19.1248092328423; Mon, 
	20 Jul 2009 05:18:48 -0700 (PDT)
In-Reply-To: <200907201342.01912.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123598>

2009/7/20 Thomas Rast <trast@student.ethz.ch>:
> demerphq wrote:
>>
>> my $can_compress=3D eval "require Compress::Zlib; 1";
>
> Wouldn't
>
> =A0my $can_compress =3D eval { require Compress::Zlib; 1 };
>
> be better on the grounds that this will catch compilation errors in
> the eval'd statement at compilation (of the main program) time?

Yeah, thats a good catch. In this case there is no need for the eval
STRING usage.

cheers,
Yves

--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
