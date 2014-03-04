From: Mahesh Pujari <pujarimahesh_kumar@yahoo.com>
Subject: Re: git compile with debug symbols
Date: Tue, 4 Mar 2014 08:33:21 -0800 (PST)
Message-ID: <1393950801.57403.YahooMailNeo@web162903.mail.bf1.yahoo.com>
References: <1393947964.16150.YahooMailNeo@web162902.mail.bf1.yahoo.com>	<87a9d6hsf3.fsf@fencepost.gnu.org> <vpqtxbene6o.fsf@anie.imag.fr>
Reply-To: Mahesh Pujari <pujarimahesh_kumar@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 17:40:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKsO4-0006Zb-4p
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 17:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755090AbaCDQkE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 11:40:04 -0500
Received: from nm37-vm8.bullet.mail.bf1.yahoo.com ([72.30.238.220]:28128 "EHLO
	nm37-vm8.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754225AbaCDQkC convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 11:40:02 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Mar 2014 11:40:02 EST
Received: from [98.139.214.32] by nm37.bullet.mail.bf1.yahoo.com with NNFMP; 04 Mar 2014 16:33:22 -0000
Received: from [98.139.212.211] by tm15.bullet.mail.bf1.yahoo.com with NNFMP; 04 Mar 2014 16:33:22 -0000
Received: from [127.0.0.1] by omp1020.mail.bf1.yahoo.com with NNFMP; 04 Mar 2014 16:33:22 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 116095.15569.bm@omp1020.mail.bf1.yahoo.com
Received: (qmail 10714 invoked by uid 60001); 4 Mar 2014 16:33:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1393950802; bh=80p3gnGBxyyYejbW/ceIfRPdYujBEXzQjGx0L7ujjfk=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=kSBV3EqQSXA1wqgP53Me+hycW9fWZHC/lrDyJJtmDZF2weM84XIS14h689jCYIsAUeq/Iqd5TnMnOyg+DZG3GaC6r4oxR56zQeUDNLdLrubsd6ZUEvJ7sNQYtqke0L/bmRjPsbC36XT29HCiBwn8DzNOz8RKIkdjifRd7qhTFlU=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CKIzhDGAek9E6vQFAEPffk2MzKZBvCsr5GybilTaKsIpfFFy1no5UbpxA9yER7v6mZYtcPSdkSP972RRwjNwhukmNgsrl0UhDKryQnXuAnJAivZTDboEXC4svIMDqkoBgSqd+V/YcUZKaIV+k8AEKu+YV/SoQId0gW0jvA9UqGQ=;
X-YMail-OSG: fVVkAhYVM1kv_9A0VtVGpss7qbY853RjS1VhG_jEwjRIBrS
 oy.Wz25ybcNB1U9Q9KAMjkmhim5uH8y0sMcNLQknVzfGaKhh3J9ZlEBkOB4q
 1RQ2zidafQIWJwwckcA9vXczoOUh3IX.yZLO4krhNoQ4sdG5MjDhPufLKpe5
 Be2sA3NLSqg7SDsF3AAdEIIQI5_d5eDH9WLM_5T3JL_5PMOys0.vvG0P_5Km
 Hbp.fsFGMtbaCDom7v_HSC26B_EQpJtx_P89gduOKaMe.Q9EugOy9iqWpu9m
 rGX4FKFS3A3e36VX7jA0QRWtgukLLdlWTiDS96CPcPjiswqpgT9UfFNcLpAR
 1RyFwxwvozj1vASzcsViiQ82gAmPlWNTI0u956W5y4kfPn615YqyXG78Qe7.
 Clx17xaT6qWxbV5sXuQl_Mmb3Q7CvVhEESEO3.qfF6NdKY.atlbC6mwFtl.i
 oOYFoEs.6sJYkHieOnKDgSEC.nt2GLGmfVXMl3OFUXSh0LsEiqh55v40M7.7
 E63LL3ohrzIsUCVyifc.qmI8AZwbAl6BO7cUY_cYjCmRl4kWVmmvh18dIboC
 2wviP5JBDwTqVuBM4mwGxAFHsbYPBXqKZ7M6Ag0A_9q_MBVbfpcljuU0HtRj
 EZdBNWBJv_EU_cDBoQOxbZobS7W8BXvk-
Received: from [49.206.99.188] by web162903.mail.bf1.yahoo.com via HTTP; Tue, 04 Mar 2014 08:33:21 PST
X-Rocket-MIMEInfo: 002.001,VGhhbmtzIERhdmlkIGZvciB0aGUgcmVwbHkuIEkgdGhpbmsgSSBuZWVkIHRvIGRvIG1vcmUgZ3JvdW5kIHdvcmsgb2YgZ29pbmcgdGhyb3VnaCBob3cgdG8gdXNlIGdkYi4KQmFzaWNhbGx5IEkgYW0gamF2YSBwcm9ncmFtbWVyIGFuZCBJIHdhcyB0cnlpbmcgb3V0IHRvIGRlYnVnIGdpdCBzb3VyY2UgdXNpbmcgZWNsaXBzZSBDRFQgYW5kIGFzIHdlIGRvIGluIGphdmEsIEkgd2FzIHRyeWluZyBvdXQgdG8gc2V0IGJyZWFrIHBvaW50IGJ1dCBmYWlsZWQgd2l0aCBlcnJvcnMgYXMgIk5vIGxpbmUgMzk2IGluIGYBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.177.636
In-Reply-To: <vpqtxbene6o.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243356>

Thanks David for the reply. I think I need to do more ground work of go=
ing through how to use gdb.
Basically I am java programmer and I was trying out to debug git source=
 using eclipse CDT and as we do in java, I was trying out to set break =
point but failed with errors as "No line 396 in file "help.c"".
And using gdb too I end up with same error.

# (gdb) break help.c:396
# No line 396 in file "help.c".


Am I missing something.

thanks,
mpujari


On Tuesday, March 4, 2014 9:34 PM, Matthieu Moy <Matthieu.Moy@grenoble-=
inp.fr> wrote:
David Kastrup <dak@gnu.org> writes:

> Mahesh Pujari <pujarimahesh_kumar@yahoo.com> writes:
>
>> Hello,
>> =A0I am trying to compile git with debug symbols and failed to do so
>> (basically I am a noob), can some one direct me to links or mailing
>> list (have searched but couldn't find) or doc's so that I can debug
>> git using gdb.
>
> git is compiled with debug symbols by default.

=2E.. but:

1) some Git commands are shell-scripts, on which you can't use gdb.

2) some Git commands fork other commands, and then you have to deal wit=
h
=A0  multiple processes (i.e. putting a breakpoint in a piece of code
=A0  executed by the subprocess won't work if gdb is running on the oth=
er

=A0  one).

--=20
Matthieu Moy
http://www-verimag.imag.fr/~moy/
