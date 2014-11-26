From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCHv2] branch -d: test if we can delete broken refs
Date: Wed, 26 Nov 2014 09:49:03 +0100
Message-ID: <547593FF.6040507@alum.mit.edu>
References: <CAGZ79kao0CpeidBzVL4O-4jfNd7nGbOJwtvsJCEgOjb370z8uw@mail.gmail.com> <1416963565-32318-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>, jrnieder@gmail.com,
	gitster@pobox.com, ronniesahlberg@gmail.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 26 09:49:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtYHs-0007tO-Bz
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 09:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbaKZItU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 03:49:20 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:55842 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750875AbaKZItT (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Nov 2014 03:49:19 -0500
X-AuditID: 12074414-f797f6d000004084-6f-547594033a85
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id E6.56.16516.30495745; Wed, 26 Nov 2014 03:49:07 -0500 (EST)
Received: from [192.168.69.130] (p4FC9601E.dip0.t-ipconnect.de [79.201.96.30])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sAQ8n3dn026761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 26 Nov 2014 03:49:04 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <1416963565-32318-1-git-send-email-sbeller@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsUixO6iqMs8pTTE4NpeNouuK91MFg29V5gt
	3t5cwmjR2/eJ1eLfhBqLzZvbWRzYPHbOusvusWBTqcfFS8oenzfJBbBEcdskJZaUBWem5+nb
	JXBn/LrNWXCMt2L9/8tsDYyfuLoYOTkkBEwkvm9tYYewxSQu3FvP1sXIxSEkcJlRonvzVHYI
	5xyTxN5lS5i7GDk4eAW0JW7vVgVpYBFQlbgwdRMLiM0moCuxqKeZCcQWFQiSOLnnOthQXgFB
	iZMzn4DViAi0MkocnyYJYjMLaEps2vCCFcQWFnCWOLtuDjPErnZGic1/TjKCJDiBEt/+3WCD
	aNCT2HH9FyuELS/RvHU28wRGgVlIdsxCUjYLSdkCRuZVjHKJOaW5urmJmTnFqcm6xcmJeXmp
	RboWermZJXqpKaWbGCHhLbKD8chJuUOMAhyMSjy8EVKlIUKsiWXFlbmHGCU5mJREeWcXA4X4
	kvJTKjMSizPii0pzUosPMUpwMCuJ8JrUAeV4UxIrq1KL8mFS0hwsSuK83xar+wkJpCeWpGan
	phakFsFkZTg4lCR4300CahQsSk1PrUjLzClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWp8MTBW
	QVI8QHs1J4PsLS5IzAWKQrSeYtTl+PDrZS+TEEtefl6qlDivKEiRAEhRRmke3ApYMnvFKA70
	sTCvE0gVDzARwk16BbSECWhJ3MxCkCUliQgpqQZG9zcv90Vd4xc/Fsi9a6ZB0apLXnyKPhFp
	TrvjPJMi9T96ed4KmM65xOnr3wNnX0m0MW24UbDK6i1v64S6O4Wy51vVUnO6/gox 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260275>

Aside from one tiny formatting nit (see below), the test looks good to
me. On the other hand, this is kind of an "aspirational test"; I don't
know that the tested functionality has ever worked or that anybody has
ever claimed that it works. So my feeling is that the addition of the
test would feel more natural in the patch series that implements the new
feature. But I don't feel strongly about it.

Michael

On 11/26/2014 01:59 AM, Stefan Beller wrote:
> From: Ronnie Sahlberg <sahlberg@google.com>
> 
> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> Changes v1->v2
>  * relocated the test from t1402 to t3200
>  * reword the commit message title to fit in with similar commits touching 
>    t/t3200-branch.sh 
> 
>  t/t3200-branch.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 432921b..fa7d7bd 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -163,6 +163,14 @@ test_expect_success 'git branch --list -d t should fail' '
>  	test_path_is_missing .git/refs/heads/t
>  '
>  
> +test_expect_failure 'git branch -d can delete ref with broken sha1' '
> +	echo "pointing nowhere" > .git/refs/heads/brokensha1 &&

Please no space between the ">" and the filename.

> +	test_when_finished "rm -f .git/refs/heads/brokensha1" &&
> +	git branch -d brokensha1 &&
> +	git branch >output &&
> +	! grep -e "brokensha1" output
> +'
> +
>  test_expect_success 'git branch --column' '
>  	COLUMNS=81 git branch --column=column >actual &&
>  	cat >expected <<\EOF &&
> 

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
