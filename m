From: =?UTF-8?B?S2lyaWxsIE3DvGxsZXI=?= <kirill.mueller@ivt.baug.ethz.ch>
Subject: Re: [PATCH] checkout: add --sparse for restoring files in sparse
 checkout mode
Date: Sun, 24 Mar 2013 20:50:08 +0100
Message-ID: <514F58F0.1050909@ivt.baug.ethz.ch>
References: <514C3249.7000100@ivt.baug.ethz.ch> <1364101583-6035-1-git-send-email-pclouds@gmail.com> <20130324181752.GA4543@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 24 20:50:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJqwG-0002WQ-Ld
	for gcvg-git-2@plane.gmane.org; Sun, 24 Mar 2013 20:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754655Ab3CXTuO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Mar 2013 15:50:14 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:15135 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754603Ab3CXTuN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Mar 2013 15:50:13 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 24 Mar
 2013 20:50:10 +0100
Received: from [129.132.209.144] (129.132.209.144) by mail.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 24 Mar
 2013 20:50:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <20130324181752.GA4543@elie.Belkin>
X-Originating-IP: [129.132.209.144]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218973>

Hi

On 03/24/2013 07:17 PM, Jonathan Nieder wrote:
> Hi,
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> --- a/Documentation/git-checkout.txt
>> +++ b/Documentation/git-checkout.txt
>> @@ -180,6 +180,13 @@ branch by running "git rm -rf ." from the top l=
evel of the working tree.
>>   Afterwards you will be ready to prepare your new files, repopulati=
ng the
>>   working tree, by copying them from elsewhere, extracting a tarball=
, etc.
>>
>> +
>> +--sparse::
>> +	In sparse checkout mode, `git checkout -- <paths>` would
>> +	update all entries matched by <paths> regardless sparse
>> +	patterns. This option only updates entries matched by <paths>
>> +	and sparse patterns.
> Hm, should this be the default?
>
> In principle, I would expect
>
> 	git checkout -- .
>
> to make the worktree match the index, respecting the sparse checkout.
> And something like
>
> 	git checkout --widen -- .
>
> to change the sparse checkout pattern.  But of course it is easily
> possible that I am missing some details of how sparse checkout is
> used in practice.
>
> What do you think?
Thank you for your opinion. I'd second that. When I do a sparse=20
checkout, I want to see only the directories I have included and not=20
excluded, unless I explicitly change that.


-Kirill
