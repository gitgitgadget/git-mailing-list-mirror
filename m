From: Mahesh Pujari <pujarimahesh_kumar@yahoo.com>
Subject: Re: git compile with debug symbols
Date: Tue, 4 Mar 2014 22:27:00 -0800 (PST)
Message-ID: <1394000820.21154.YahooMailNeo@web162905.mail.bf1.yahoo.com>
References: <1393947964.16150.YahooMailNeo@web162902.mail.bf1.yahoo.com>	<87a9d6hsf3.fsf@fencepost.gnu.org> <vpqtxbene6o.fsf@anie.imag.fr>	<1393950801.57403.YahooMailNeo@web162903.mail.bf1.yahoo.com> <8761ntj4ny.fsf@fencepost.gnu.org>
Reply-To: Mahesh Pujari <pujarimahesh_kumar@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Mar 05 07:33:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL5Oj-0000s7-00
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 07:33:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbaCEGdk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Mar 2014 01:33:40 -0500
Received: from nm21.bullet.mail.bf1.yahoo.com ([98.139.212.180]:46863 "EHLO
	nm21.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753443AbaCEGd0 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Wed, 5 Mar 2014 01:33:26 -0500
X-Greylist: delayed 385 seconds by postgrey-1.27 at vger.kernel.org; Wed, 05 Mar 2014 01:33:25 EST
Received: from [98.139.214.32] by nm21.bullet.mail.bf1.yahoo.com with NNFMP; 05 Mar 2014 06:27:00 -0000
Received: from [98.139.212.242] by tm15.bullet.mail.bf1.yahoo.com with NNFMP; 05 Mar 2014 06:27:00 -0000
Received: from [127.0.0.1] by omp1051.mail.bf1.yahoo.com with NNFMP; 05 Mar 2014 06:27:00 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 196893.27063.bm@omp1051.mail.bf1.yahoo.com
Received: (qmail 99444 invoked by uid 60001); 5 Mar 2014 06:27:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1394000820; bh=dYTYAItRx7e2mZo7BdLLQLHkLm0wubdWoMiPJrh/L/A=; h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding; b=STfdtE3QbqQI00StBKp5K+jYBvzlv4MhXLOsfKTkzAvweDD5zg+6eX39H74TptIcPtVFxo8+lbDpuQnvRAWqjLuEGK/JlLotVqyVYJ0pIN9FbFfHhWL+aMCa7CM4jCanblMp1q9jSWjkM+QgWPsSA1SEom/E0HkKynXQRflDBok=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=X-YMail-OSG:Received:X-Rocket-MIMEInfo:X-Mailer:References:Message-ID:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=CCV/oDslKmkhI2huc9FqfkE7XHLlg3CdQRFOJ3OaUB6Eo2G/v0zfhkH8IA/CFf+g2JX73VTzIuTsURHG8uZBY1ZiRgrgGJT2mmFE6anatR1GtoLEEYO2hhT2RTXZk446NN9hziU1VXegsKZJDpF72n1JpUDE+CpbQzzIvM0nYw4=;
X-YMail-OSG: xmhTI4UVM1n2FAJscgIle.oPp_UIMt8yfqza0I1ifMAw3ld
 _4HcklC_.GTR48WPVTJMcLYan6oCHTj4MmE_3nH7OdbjD4sszRvx5mlK4GVw
 qRRATuTuqtELvA_FkcVjOVShudbmLxMeeiJ1sicviGaE9PS1Q6nX9hh.BA9F
 wCSNiff9jbiCHMlSMlo8TZi2t1vT3dlPk5aJNuuPtKxX3moNqTfv9cCXOEP2
 YFmZRBiEKqkWmg_3ORqdz8mAFn6TxGykozv0516so8F522tfxnqs9QW3pIO9
 1YP4_J.zzKTi.KGMgPrTlRXomy8HkxoGsE2iIbxjw_dUJwVLWlialwqQcO4B
 QttSYlsQ_2mTdqi2aCzdC8CgSBE5kAazAeWsaLSMlKqeBkgfDtM28X2NDRGv
 Abd0nXAZ6Ijd9VxdycxjH2fKGwLgx96jMxPcbZD7BsSMQy5xNWm4VmkGg97f
 SkE_SKI6dxXx8AKDzAMPPsRiwEgQA_Mredy05NzeLsS7V7zPMmLkCpKPuZqu
 .MP_IJQyT.qMcULsmgvKtFht6yS3Oy9F1JAspchRQ9CKFGeXS88bSwwfOO91
 KGva4IIfCM9r7_GvMgQg5DmxO.FeTSs0tbA--
Received: from [14.141.6.170] by web162905.mail.bf1.yahoo.com via HTTP; Tue, 04 Mar 2014 22:27:00 PST
X-Rocket-MIMEInfo: 002.001,SGVsbG8gYWxsLArCoFRoYW5rcyBmb3IgcmVwbHlpbmcgYmFjaywgZmlndXJlZCBvdXQgKG9mZmNvdXJzZSBoYWQgdG8gc2VhcmNoIGluIG5ldCkgdGhhdCAnZ2RiJyB2ZXJzaW9uIEkgaGFkIHdhcyA2LjcuMSAoT1MgVWJ1bnR1IDEyLjA0IExTVCksIG5vdCBzdXJlIGhvdyBJIGdvdCB0aGlzLiBUaGVuIEkgdXBncmFkZWQgZ2RiIHRvIHZlcnNpb24gNy40LTIwMTIuMDQgYW5kIHRoaW5ncyBnb3QgZ29pbmcuCgoKdGhhbmtzLAptcHVqYXJpCgoKT24gVHVlc2RheSwgTWFyY2ggNCwgMjAxNCAxMDoxMyBQTSwgRGEBMAEBAQE-
X-Mailer: YahooMailWebService/0.8.177.636
In-Reply-To: <8761ntj4ny.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243420>

Hello all,
=A0Thanks for replying back, figured out (offcourse had to search in ne=
t) that 'gdb' version I had was 6.7.1 (OS Ubuntu 12.04 LST), not sure h=
ow I got this. Then I upgraded gdb to version 7.4-2012.04 and things go=
t going.


thanks,
mpujari


On Tuesday, March 4, 2014 10:13 PM, David Kastrup <dak@gnu.org> wrote:
Mahesh Pujari <pujarimahesh_kumar@yahoo.com> writes:

> Thanks David for the reply. I think I need to do more ground work of
> going through how to use gdb.
> Basically I am java programmer and I was trying out to debug git
> source using eclipse CDT and as we do in java, I was trying out to se=
t
> break point but failed with errors as "No line 396 in file "help.c"".
> And using gdb too I end up with same error.
>
> # (gdb) break help.c:396
> # No line 396 in file "help.c".
>
>
> Am I missing something.

There is just no line 396 known to gdb.=A0 It seems like you are
indicating a function header.=A0 That's not code.=A0 Either take the
function _name_ rather than a line number (that's usually most reliable=
)
or take the first line of actual code.


--=20
David Kastrup
