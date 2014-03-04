From: Mahesh Pujari <pujarimahesh_kumar@yahoo.com>
Subject: git compile with debug symbols
Date: Tue, 4 Mar 2014 07:46:04 -0800 (PST)
Message-ID: <1393947964.16150.YahooMailNeo@web162902.mail.bf1.yahoo.com>
Reply-To: Mahesh Pujari <pujarimahesh_kumar@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 04 16:46:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKrXp-00061H-UN
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 16:46:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbaCDPqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2014 10:46:07 -0500
Received: from nm43-vm4.bullet.mail.bf1.yahoo.com ([216.109.114.223]:46272
	"EHLO nm43-vm4.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752717AbaCDPqG convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 10:46:06 -0500
Received: from [98.139.215.142] by nm43.bullet.mail.bf1.yahoo.com with NNFMP; 04 Mar 2014 15:46:04 -0000
Received: from [98.139.212.202] by tm13.bullet.mail.bf1.yahoo.com with NNFMP; 04 Mar 2014 15:46:04 -0000
Received: from [127.0.0.1] by omp1011.mail.bf1.yahoo.com with NNFMP; 04 Mar 2014 15:46:04 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 895338.803.bm@omp1011.mail.bf1.yahoo.com
Received: (qmail 1531 invoked by uid 60001); 4 Mar 2014 15:46:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1393947964; bh=Grep3Cy5AxEdMsdp4cSykT9nT/sBsUTNpmyKnmqUZBs=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=tCABgOQCY91TKsNwsli6SwoAH/349xT+IDDGJUoxsLiiOI8SSo3MVELvAEdP2AUAdhEX/LSE0SdcPWwTQdVAZSoL6mB5AgLyDf7USTscqfv9VBYJAYhL/aKSob39SB/GwWRYMwtQK0edIKNzdqtSy5K0xLKKEymP6cHu6+VIQ2A=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:Message-ID:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=dHmkg7934tHH7AQCNt7da48MLp0PJ8rwRNo/KGTYNnSLS9wT5vtX6CBlxOwSlH9RuqOK7hPt1ccMyUXZNWiBTM4d1F5zeGVNNOnb7muxTX7satp3DhXbmwvcrAW5HHVxrEeROUOSfzWwXPMez7A5k2uVFfZvOzsJgRsyzshIBqs=;
X-YMail-OSG: 54zBiKEVM1ncQjbzzyXAtePGbzSe9IRuvKrri36tOiWXKVJ
 Y6UQFQec_TcIMwNoJiuWKDrXV.RmT2gomRXuZ_Cev.4NEVPbOyH9fzwinyb.
 U.E7A_GTfvDYs9Dq75esQElrf2_97OdrlhsdbcDJlbeTmTK7dj3t77Vx.LvV
 T1QakGngsDXqUSNiEiFJ8AUHyOyr02AKydxOAdX.NtCBzErNPipyQqyQY5mY
 lIGvoFXhlEDQDJbiCPDae8izGv4Hjh8h64nUyhdzwFCJZPTM7hVk62ruLhTm
 2fif9UYOEBkrDmU_V_oanFSUMUJYEg.uXEEeU3BZu.4QK20hoHvmtTIkUdsw
 y6VT2J.6Zxf_NanQSGgyx1vQGqTnyCuYeX40u7tKLiLy5Aerrl_2bFv3OPr6
 rTMEjo_plurjfTClmhG6vCx2WD7mZsjZ3z4D0wc3op3cR_PareHOQXQCSmkv
 K8BmKkPbQheFsBkDzD224upSlhCCR91_P0kDuOZToYkOs39f8x2XWLdAWvbx
 xju6x08LA29C.We1NiWLb8MAN.K5.z6PBXUqUnYHqlFsqGcItnz08LAEnUmj
 pcNpjwIPBNfr5ANOFeMqbHJo-
Received: from [49.206.99.188] by web162902.mail.bf1.yahoo.com via HTTP; Tue, 04 Mar 2014 07:46:04 PST
X-Rocket-MIMEInfo: 002.001,CgpIZWxsbywKwqBJIGFtIHRyeWluZyB0byBjb21waWxlIGdpdCB3aXRoIGRlYnVnIHN5bWJvbHMgYW5kIGZhaWxlZCB0byBkbyBzbyAoYmFzaWNhbGx5IEkgYW0gYSBub29iKSwgY2FuIHNvbWUgb25lIGRpcmVjdCBtZSB0byBsaW5rcyBvciBtYWlsaW5nIGxpc3QgKGhhdmUgc2VhcmNoZWQgYnV0IGNvdWxkbid0IGZpbmQpIG9yIGRvYydzIHNvIHRoYXQgSSBjYW4gZGVidWcgZ2l0IHVzaW5nIGdkYi4KCnRoYW5rcywKbXB1amFyaQoBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.177.636
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243349>



Hello,
=A0I am trying to compile git with debug symbols and failed to do so (b=
asically I am a noob), can some one direct me to links or mailing list =
(have searched but couldn't find) or doc's so that I can debug git usin=
g gdb.

thanks,
mpujari
