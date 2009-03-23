From: David Reitter <david.reitter@gmail.com>
Subject: Re: Importing Bzr revisions
Date: Mon, 23 Mar 2009 08:13:31 -0400
Message-ID: <30CDC575-120E-4FAE-8B4D-1971954E913A@gmail.com>
References: <90DBD254-1810-4B11-AA9F-C5661A028FA5@gmail.com> <7veiwo8xz7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/signed; boundary=Apple-Mail-23--342309933; micalg=sha1; protocol="application/pkcs7-signature"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 13:15:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llj3g-0002J4-H5
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 13:15:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753897AbZCWMNk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 08:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753854AbZCWMNk
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 08:13:40 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:49313 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753786AbZCWMNj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 08:13:39 -0400
Received: by qyk16 with SMTP id 16so2408480qyk.33
        for <git@vger.kernel.org>; Mon, 23 Mar 2009 05:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:cc:message-id:from:to
         :in-reply-to:content-type:mime-version:subject:date:references
         :x-mailer;
        bh=w7w136SEOdtanRg9YtChycESgc9AglRn9NNdY8AA3i0=;
        b=RktzokJRbb3QnescBKYzB3ehPjpncje/zVqUeAUjjhVn9bad1Fq0/DBN4L6g/q/3oc
         51UKqExpqfQ2KVP2y1BiOy49TKXO+DtPGCdaCrPyB83d6Ph0/s2u7WDpy7tpP4zVyLXP
         Iv+FsNKTm3S62PFWzwVAuB6dxmwVIc5NaZOIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=cc:message-id:from:to:in-reply-to:content-type:mime-version:subject
         :date:references:x-mailer;
        b=HHc558EKrqyqHChrE7rCJfKyzy+o7ui+cjN3u8EMBt/ND1tWtNAwfKoDErPv9FP+tN
         l9MAO9ZdpUr9mafh7Ii9uq6OXA+H17Qs8K2N6W4y2hI/gGbjztxiiAw87zsXHqNwVQ/b
         latJu9lzlVHqj0CAxMj2busXWvazH6EKenkxE=
Received: by 10.224.53.202 with SMTP id n10mr8678175qag.194.1237810417025;
        Mon, 23 Mar 2009 05:13:37 -0700 (PDT)
Received: from ?192.168.1.42? (pool-72-65-195-138.pitbpa.east.verizon.net [72.65.195.138])
        by mx.google.com with ESMTPS id 30sm4558489yxk.32.2009.03.23.05.13.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Mar 2009 05:13:35 -0700 (PDT)
In-Reply-To: <7veiwo8xz7.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.930.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114293>


--Apple-Mail-23--342309933
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

On Mar 23, 2009, at 4:06 AM, Junio C Hamano wrote:

> David Reitter <david.reitter@gmail.com> writes:
>
>> Suppose I have a bzr branch that has been converted (somehow) to a  
>> git
>> branch, is it then possible to merge new revisions from the bzr  
>> branch
>> into the git one?
>
> It entirely depends on how that "somehow" goes.
>
> If that "somehow" procedure performs a reliably reproducible  
> conversion
> (i.e. not only it will produce the identical git history when you  
> feed the

The question is then:  How would one reliably convert a Bzr branch to  
git?  One branch is enough for me, but we're talking >100k revisions,  
so if the procedure involves Bzr tools, it will take longer then is  
practicable.

Also, my impression is that not many people are doing this, because  
the fast-export/import combination hasn't seen a lot of development  
activity.  I'm a bit wary to set up my project in git when I don't  
just need to convert once, but in future convert and merge pretty much  
every day...  (The upstream project is going to use Bzr, while I am  
trying to see if Git is an option for me downstream.)
--Apple-Mail-23--342309933
Content-Disposition: attachment;
	filename=smime.p7s
Content-Type: application/pkcs7-signature;
	name=smime.p7s
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIFxDCCAn0w
ggHmoAMCAQICED6shx13jEDrq0eL8FRq5ykwDQYJKoZIhvcNAQEFBQAwYjELMAkGA1UEBhMCWkEx
JTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAqBgNVBAMTI1RoYXd0ZSBQ
ZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMB4XDTA4MTIwOTAyMDgwMVoXDTA5MTIwOTAyMDgw
MVowYjEQMA4GA1UEBBMHUmVpdHRlcjEOMAwGA1UEKhMFRGF2aWQxFjAUBgNVBAMTDURhdmlkIFJl
aXR0ZXIxJjAkBgkqhkiG9w0BCQEWF2RhdmlkLnJlaXR0ZXJAZ21haWwuY29tMIGfMA0GCSqGSIb3
DQEBAQUAA4GNADCBiQKBgQDOdo6kAwlkBxUb8dj4saMbYg4SVng8CUePFn3cjjWrakBTbUVa4Z0n
wlUxr7AitEeKhBy5nGhu96+jKUPrCwYNRCZ0l2ovvuGq4z1m1nZ5/c8WvFlVhieuxXMUfmb/O7D3
IojoX6iS8n5MNNU2IWNNT/AD3vOl6DKgOtOw4J9y+QIDAQABozQwMjAiBgNVHREEGzAZgRdkYXZp
ZC5yZWl0dGVyQGdtYWlsLmNvbTAMBgNVHRMBAf8EAjAAMA0GCSqGSIb3DQEBBQUAA4GBAIjI8yEW
wkiEfA9PMgpjnD6KyCXT0iZjHhW2PkR53yZZLUoTboHnKgsFwYp/gzzIL8J5cvZaRUyMUzXDufPP
dRmxxCs2jXXLDD/8bvdvOuMzqgYoFA73fAfsC8S6qUL1PayZ90J8CZHNhDwqWqOA56T+DdKUegJT
sqoHKh6OnypTMIIDPzCCAqigAwIBAgIBDTANBgkqhkiG9w0BAQUFADCB0TELMAkGA1UEBhMCWkEx
FTATBgNVBAgTDFdlc3Rlcm4gQ2FwZTESMBAGA1UEBxMJQ2FwZSBUb3duMRowGAYDVQQKExFUaGF3
dGUgQ29uc3VsdGluZzEoMCYGA1UECxMfQ2VydGlmaWNhdGlvbiBTZXJ2aWNlcyBEaXZpc2lvbjEk
MCIGA1UEAxMbVGhhd3RlIFBlcnNvbmFsIEZyZWVtYWlsIENBMSswKQYJKoZIhvcNAQkBFhxwZXJz
b25hbC1mcmVlbWFpbEB0aGF3dGUuY29tMB4XDTAzMDcxNzAwMDAwMFoXDTEzMDcxNjIzNTk1OVow
YjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4xLDAq
BgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBMIGfMA0GCSqGSIb3DQEB
AQUAA4GNADCBiQKBgQDEpjxVc1X7TrnKmVoeaMB1BHCd3+n/ox7svc31W/Iadr1/DDph8r9RzgHU
5VAKMNcCY1osiRVwjt3J8CuFWqo/cVbLrzwLB+fxH5E2JCoTzyvV84J3PQO+K/67GD4Hv0CAAmTX
p6a7n2XRxSpUhQ9IBH+nttE8YQRAHmQZcmC3+wIDAQABo4GUMIGRMBIGA1UdEwEB/wQIMAYBAf8C
AQAwQwYDVR0fBDwwOjA4oDagNIYyaHR0cDovL2NybC50aGF3dGUuY29tL1RoYXd0ZVBlcnNvbmFs
RnJlZW1haWxDQS5jcmwwCwYDVR0PBAQDAgEGMCkGA1UdEQQiMCCkHjAcMRowGAYDVQQDExFQcml2
YXRlTGFiZWwyLTEzODANBgkqhkiG9w0BAQUFAAOBgQBIjNFQg+oLLswNo2asZw9/r6y+whehQ5aU
nX9MIbj4Nh+qLZ82L8D0HFAgk3A8/a3hYWLD2ToZfoSxmRsAxRoLgnSeJVCUYsfbJ3FXJY3dqZw5
jowgT2Vfldr394fWxghOrvbqNOUQGls1TXfjViF4gtwhGTXeJLHTHUb/XV9lTzGCAo8wggKLAgEB
MHYwYjELMAkGA1UEBhMCWkExJTAjBgNVBAoTHFRoYXd0ZSBDb25zdWx0aW5nIChQdHkpIEx0ZC4x
LDAqBgNVBAMTI1RoYXd0ZSBQZXJzb25hbCBGcmVlbWFpbCBJc3N1aW5nIENBAhA+rIcdd4xA66tH
i/BUaucpMAkGBSsOAwIaBQCgggFvMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTA5MDMyMzEyMTMzMVowIwYJKoZIhvcNAQkEMRYEFCKPS/vtgjJOpOPmy8XawnagHnYx
MIGFBgkrBgEEAYI3EAQxeDB2MGIxCzAJBgNVBAYTAlpBMSUwIwYDVQQKExxUaGF3dGUgQ29uc3Vs
dGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUgUGVyc29uYWwgRnJlZW1haWwgSXNzdWlu
ZyBDQQIQPqyHHXeMQOurR4vwVGrnKTCBhwYLKoZIhvcNAQkQAgsxeKB2MGIxCzAJBgNVBAYTAlpB
MSUwIwYDVQQKExxUaGF3dGUgQ29uc3VsdGluZyAoUHR5KSBMdGQuMSwwKgYDVQQDEyNUaGF3dGUg
UGVyc29uYWwgRnJlZW1haWwgSXNzdWluZyBDQQIQPqyHHXeMQOurR4vwVGrnKTANBgkqhkiG9w0B
AQEFAASBgC9CW/Gq2Dto1mkpMbwzKy0eNpepTDWPSIGCiYaKqvSWWmyCAmJXS3vfbQCDIttuy7fM
bErRMHILsz0Bce35icJzYD/c1aLH1vIBH0SJIXd9PWUi4N08qLb0jE5EULEYLi/CNk7WokKOxFYm
kkrem225bmaZVf6bbUygQCTRkLVMAAAAAAAA

--Apple-Mail-23--342309933--
