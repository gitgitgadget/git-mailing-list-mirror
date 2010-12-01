From: GAURAV BAHL <engg.bahl@gmail.com>
Subject: GIT connect "connect to host HOSTNAME port 22: Bad file
 number" message shown
Date: Wed, 1 Dec 2010 07:48:56 -0500
Message-ID: <AANLkTi=GnOJvZE1hGcCbRq9G8KrqnM2ULXZXRCAP-Gpv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary=0015175cb5aa794c62049658bae1
Cc: git@vger.kernel.org
To: msysgit@googlegroups.com
X-From: msysgit+bncCLjjpez7ARCqm9nnBBoEr9QbuQ@googlegroups.com Wed Dec 01 14:29:41 2010
Return-path: <msysgit+bncCLjjpez7ARCqm9nnBBoEr9QbuQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-qy0-f186.google.com ([209.85.216.186])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncCLjjpez7ARCqm9nnBBoEr9QbuQ@googlegroups.com>)
	id 1PNmkd-0003Fq-FH
	for gcvm-msysgit@m.gmane.org; Wed, 01 Dec 2010 14:29:39 +0100
Received: by qyk9 with SMTP id 9sf15065619qyk.3
        for <gcvm-msysgit@m.gmane.org>; Wed, 01 Dec 2010 05:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:x-beenthere:received:received:received
         :received:received:received-spf:received:mime-version:received
         :received:date:message-id:subject:from:to:cc:x-original-sender
         :x-original-authentication-results:precedence:mailing-list:list-id
         :list-post:list-help:list-archive:sender:list-subscribe
         :list-unsubscribe:content-type;
        bh=MSmGlvBGlSwDr7PDJxsIQf5LQoHKmEw/0wKu1no4o8s=;
        b=YmRnwZaLffVoJF0z1wFkJs3OHSMUUgnwIFsFcBvE5P5+9Hz7H+04Cv2vzgORnp5TlD
         7nFdx9dM+OHCtozxwA3xkEGjJ32C453mjZT3Hi9LHJcNyE2xTFUnvTy4HE3KR+KZbHgy
         W0V1b8FJ2E4wbl9Lk4Y4MsTmJFBN6DN6OUYgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-beenthere:received-spf:mime-version:date:message-id:subject:from
         :to:cc:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type;
        b=L2UlautHHI8I0NxCo99roleij1c1ZR9+mP0e5sUC0s88OGYmz/lxvPbFdaRN0djf6L
         VdjxVZD1PmjTTrh20+wsZijNSHX1Gvi3J9YUhFgsFx0b8Tx5dyTm5FzqKFwxkIw1dvi+
         J7orbsjDf87sdTBLDD9q7jr3sSiTy0ER8rWjU=
Received: by 10.224.67.84 with SMTP id q20mr360470qai.46.1291210154359;
        Wed, 01 Dec 2010 05:29:14 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.224.182.9 with SMTP id ca9ls39892qab.3.p; Wed, 01 Dec 2010
 05:29:13 -0800 (PST)
Received: by 10.224.28.73 with SMTP id l9mr815745qac.4.1291210153791;
        Wed, 01 Dec 2010 05:29:13 -0800 (PST)
Received: by 10.229.38.140 with SMTP id b12mr952098qce.14.1291207737773;
        Wed, 01 Dec 2010 04:48:57 -0800 (PST)
Received: by 10.229.38.140 with SMTP id b12mr952097qce.14.1291207737739;
        Wed, 01 Dec 2010 04:48:57 -0800 (PST)
Received: from mail-qw0-f43.google.com (mail-qw0-f43.google.com [209.85.216.43])
        by gmr-mx.google.com with ESMTP id e24si1578489qcg.5.2010.12.01.04.48.56;
        Wed, 01 Dec 2010 04:48:56 -0800 (PST)
Received-SPF: pass (google.com: domain of engg.bahl@gmail.com designates 209.85.216.43 as permitted sender) client-ip=209.85.216.43;
Received: by mail-qw0-f43.google.com with SMTP id 3so1430750qwk.30
        for <msysgit@googlegroups.com>; Wed, 01 Dec 2010 04:48:56 -0800 (PST)
Received: by 10.224.45.130 with SMTP id e2mr664319qaf.22.1291207736642; Wed,
 01 Dec 2010 04:48:56 -0800 (PST)
Received: by 10.220.11.141 with HTTP; Wed, 1 Dec 2010 04:48:56 -0800 (PST)
X-Original-Sender: engg.bahl@gmail.com
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com:
 domain of engg.bahl@gmail.com designates 209.85.216.43 as permitted sender)
 smtp.mail=engg.bahl@gmail.com; dkim=pass (test mode) header.i=@gmail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=en_US>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=en_US>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=en_US>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=en_US>, <mailto:msysgit+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162513>

--0015175cb5aa794c62049658bae1
Content-Type: text/plain; charset=ISO-8859-1

My Manager asked me sent it out c/Documents and Settings
Administrator/.ssh/id_rsa.pub file to someone for adding so that git should
be available to me.
Once done with the approval , I tried with above command and faced Bad file
name issue

Let me know for more Infn.

After addition of the key the GIT bash Testing connection using (ssh
git@HOSTNAME info) command outputs as

gaurav.bahl@008_GAURAVB ~
$ ssh git@HOSTNAME info
ssh: connect to host HOSTNAME port 22: Bad file number

-- 
Gaurav
+91-986-888-0002

--0015175cb5aa794c62049658bae1
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br clear=3D"all">My Manager asked me sent it out c/Documents and Settings =
Administrator/.ssh/id_rsa.pub file to someone for adding so that git should=
 be available to me.<br>Once done with the approval , I tried with above co=
mmand and faced Bad file name issue<br>
<br>Let me know for more Infn.<br><div><br></div><div>After addition of the=
 key the GIT bash Testing connection using (ssh git@HOSTNAME info) command =
outputs as=A0<br></div><br>gaurav.bahl@008_GAURAVB ~<br>$ ssh git@HOSTNAME =
info<br>
<div>ssh: connect to host HOSTNAME port 22: Bad file number<br></div><br>--=
 <br>Gaurav<br>+91-986-888-0002<br>

--0015175cb5aa794c62049658bae1--
