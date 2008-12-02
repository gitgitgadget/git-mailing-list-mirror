From: Nicholas Wieland <nicholas.wieland@gmail.com>
Subject: Re: Overwrite master
Date: Tue, 2 Dec 2008 21:09:45 +0100
Message-ID: <67A24C29-12A6-43B0-95D5-70910C5F8841@gmail.com>
References: <D1AC0A41-E89A-4B53-A449-DA9C4422998E@zooppa.com> <eaa105840812020832p395ecefdq57e62f95182a3557@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v929.2)
Content-Type: multipart/signed; boundary=Apple-Mail-3-833282597; micalg=sha1; protocol="application/pkcs7-signature"
Cc: git@vger.kernel.org
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 21:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7bas-0006HE-5S
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 21:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbYLBUJ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 15:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbYLBUJ4
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 15:09:56 -0500
Received: from fk-out-0910.google.com ([209.85.128.191]:57734 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750982AbYLBUJy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 15:09:54 -0500
Received: by fk-out-0910.google.com with SMTP id 18so2575977fkq.5
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 12:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:mime-version:subject:date:references
         :x-mailer;
        bh=G1PTYja726U+eyFPY9g0g3lTQAY/n8WZGTxldEFpNd4=;
        b=KtKqN8LqKob5JXZUAjlNL5xmCQos07uVMRtM3YU/u2mI/BE5I98gc4Krn/jnl550Rf
         yhiMTaCwPIZUKp/jcPe8yBwvAMq5ORt4wUrJmCeLkRG/f444TJ/6JjW3gIPZr/yGk6RK
         BBgMkefhS9BAb7f1PSjFCIlvG9vWpx6CXPPPM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:mime-version:subject
         :date:references:x-mailer;
        b=VQ/+PYwEvHB0ovcNcW2nPlzbZm3JZLJ7uwWEd78viH6GqhtyS0VNjR+8o4HlFjJQ1t
         KbsmmzCE+WcjOGwLFJzoY4G7vWGEaS0aQLuexW6XSyO/JWJTNVBOZSzWq73XxLlGDZ7S
         uoDta+Vq3rmocdR5QeeIUL8oDXTsihRV3W2oA=
Received: by 10.181.60.14 with SMTP id n14mr4370761bkk.79.1228248592730;
        Tue, 02 Dec 2008 12:09:52 -0800 (PST)
Received: from ?1.227.88.33? (89-96-108-180.ip12.fastwebnet.it [89.96.108.180])
        by mx.google.com with ESMTPS id d13sm6898675fka.5.2008.12.02.12.09.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Dec 2008 12:09:51 -0800 (PST)
In-Reply-To: <eaa105840812020832p395ecefdq57e62f95182a3557@mail.gmail.com>
X-Mailer: Apple Mail (2.929.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102171>


--Apple-Mail-3-833282597
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Il giorno 02/dic/08, alle ore 17:32, Peter Harris ha scritto:

> On Tue, Dec 2, 2008 at 11:10 AM, Nicholas Wieland wrote:
>> Hi *,
>> I need to overwrite my master branch with another branch. I've  
>> already
>> created a backup branch of my master.
>
> While on master,
> "git reset --hard <newbranch>"
>
> Or while on a different branch,
> git branch -D master
> git branch master <newbranch>

That's what I tried.
Unfortunately I don't know where to go after:

ngw@slicingupeyeballs ~/zooppa$ git commit
# On branch master
# Your branch and 'origin/master' have diverged,
# and have 444 and 25 different commit(s) each, respectively.
#
nothing to commit (working directory clean)

Do I have to push ? If I pull it tries to merge ...


Thanks a lot for your time,
   ngw


--Apple-Mail-3-833282597
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIGNTCCAu4w
ggJXoAMCAQICED5xMqqxuqfS6jyxOxKsJrswDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MDQwODExMDI0OFoXDTA5MDQwODExMDI0
OFowTDEfMB0GA1UEAxMWVGhhd3RlIEZyZWVtYWlsIE1lbWJlcjEpMCcGCSqGSIb3DQEJARYabmlj
aG9sYXMud2llbGFuZEBnbWFpbC5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDC
beybG0TtTgVzg6riNdw6mpKDIP7XaKm3yE/EVchdPVKBmfru/kGuVxaP0f7s3bjQEWxgZQzl+4jK
JlWXO52n1U/Zp6s08xVqw5zgkL4UIucwXXp3PWEYb0/FyqX0eGbYa0nk6CIZHUhEIyVAqn/shSJj
bYWMyTOfra7ezd4EDdNjBkUACmQ/SZIGLNbBpzMoM8lh1aRjwKkbXJU0X09oVV3epMNjTh6xJcCd
EWl5OxYr/DIpAzpScKidy7cIi0SP18B1oC8Vpe/Ych7TTV+QAtufF8r829QxsxQ2oojStM440P9j
xVYzgYbk2gttFMpgWz9FbodJC72owAV2zdsJAgMBAAGjNzA1MCUGA1UdEQQeMByBGm5pY2hvbGFz
LndpZWxhbmRAZ21haWwuY29tMAwGA1UdEwEB/wQCMAAwDQYJKoZIhvcNAQEFBQADgYEAvweWM4I5
KG26YFwmDQvdmSTgQ+vyWWXRT2KwQjBMKzE35xCL/UDGpJvNpSTkc31YuH538mKAnMDLrN3ml6Bw
T2R+oIpsIMSom+sMtwYqTFSP5ShqnPK77jE502NpEWe0Vw7Jrupt3Grszn3Roc3j1le9znBdEwXL
YK1U1XAH+fgwggM/MIICqKADAgECAgENMA0GCSqGSIb3DQEBBQUAMIHRMQswCQYDVQQGEwJaQTEV
MBMGA1UECBMMV2VzdGVybiBDYXBlMRIwEAYDVQQHEwlDYXBlIFRvd24xGjAYBgNVBAoTEVRoYXd0
ZSBDb25zdWx0aW5nMSgwJgYDVQQLEx9DZXJ0aWZpY2F0aW9uIFNlcnZpY2VzIERpdmlzaW9uMSQw
IgYDVQQDExtUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgQ0ExKzApBgkqhkiG9w0BCQEWHHBlcnNv
bmFsLWZyZWVtYWlsQHRoYXd0ZS5jb20wHhcNMDMwNzE3MDAwMDAwWhcNMTMwNzE2MjM1OTU5WjBi
MQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEsMCoG
A1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0EwgZ8wDQYJKoZIhvcNAQEB
BQADgY0AMIGJAoGBAMSmPFVzVftOucqZWh5owHUEcJ3f6f+jHuy9zfVb8hp2vX8MOmHyv1HOAdTl
UAow1wJjWiyJFXCO3cnwK4Vaqj9xVsuvPAsH5/EfkTYkKhPPK9Xzgnc9A74r/rsYPge/QIACZNen
prufZdHFKlSFD0gEf6e20TxhBEAeZBlyYLf7AgMBAAGjgZQwgZEwEgYDVR0TAQH/BAgwBgEB/wIB
ADBDBgNVHR8EPDA6MDigNqA0hjJodHRwOi8vY3JsLnRoYXd0ZS5jb20vVGhhd3RlUGVyc29uYWxG
cmVlbWFpbENBLmNybDALBgNVHQ8EBAMCAQYwKQYDVR0RBCIwIKQeMBwxGjAYBgNVBAMTEVByaXZh
dGVMYWJlbDItMTM4MA0GCSqGSIb3DQEBBQUAA4GBAEiM0VCD6gsuzA2jZqxnD3+vrL7CF6FDlpSd
f0whuPg2H6otnzYvwPQcUCCTcDz9reFhYsPZOhl+hLGZGwDFGguCdJ4lUJRix9sncVcljd2pnDmO
jCBPZV+V2vf3h9bGCE6u9uo05RAaWzVNd+NWIXiC3CEZNd4ksdMdRv9dX2VPMYIDEDCCAwwCAQEw
djBiMQswCQYDVQQGEwJaQTElMCMGA1UEChMcVGhhd3RlIENvbnN1bHRpbmcgKFB0eSkgTHRkLjEs
MCoGA1UEAxMjVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIElzc3VpbmcgQ0ECED5xMqqxuqfS6jyx
OxKsJrswCQYFKw4DAhoFAKCCAW8wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMDgxMjAyMjAwOTQ2WjAjBgkqhkiG9w0BCQQxFgQUeqHemvBu4xESBIkpDI1csiFACM0w
gYUGCSsGAQQBgjcQBDF4MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0
aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5n
IENBAhA+cTKqsbqn0uo8sTsSrCa7MIGHBgsqhkiG9w0BCRACCzF4oHYwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA+cTKqsbqn0uo8sTsSrCa7MA0GCSqGSIb3DQEB
AQUABIIBAJWqh9Cu/HpgsbcKb6e2oAg32/+CzyF2uH++vnMQxmivll6kINAHDtIj8MWNJaxQgWPG
gHRwhundDggjuRIt7XLBxkjl7JQMh81+ALODDz86cStEbn4xkcKIbZ/XoyaX0YswFWOo6cAubtu/
2QcqX2r/BjRUhveOsAThrmmjTcrU3coPN59zEq05n/BT32upQYjIQ+VjyQRYDmILDOnqtipTaMZ3
Iibru+4uq/fkW2MYZykNOAHOYQt3XBS4s5BfHB1sCIfDrJhrAcesnWt4gBO/8Sp+ffgNYJsjO6cI
XHP4yt/IFw9mpFcPDng1sNc4/sl1vEGHodvwbZOJSW6glmQAAAAAAAA=

--Apple-Mail-3-833282597--
