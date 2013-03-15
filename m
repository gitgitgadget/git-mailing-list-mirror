From: Paul Campbell <pcampbell@kemitix.net>
Subject: Re: building git ; need suggestion
Date: Fri, 15 Mar 2013 17:25:26 +0000
Message-ID: <CALeLG_mSkHfpBkfDu_MCe_rQBxGa_1i==mf9cBSwurYgv3EbfQ@mail.gmail.com>
References: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in>
	<20130315124415.GA23122@paksenarrion.iveqy.com>
	<00107242-04EB-423F-90FE-A6DCDEE7E262@infoservices.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Fri Mar 15 18:25:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGYOA-0000U4-Ef
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 18:25:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901Ab3CORZ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 13:25:28 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:54881 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419Ab3CORZ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Mar 2013 13:25:27 -0400
Received: by mail-oa0-f54.google.com with SMTP id n12so3699661oag.13
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 10:25:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:x-received:x-originating-ip:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=PeC1VQ+RcL0Cu35+L25WV+mYCSknBSg3xsV4HqNeQqM=;
        b=En01xN/qOolic/50DpFJqWDNAWiioKpN8FqgsYbIVQryOMyPKrYEjUtDSxisOMtCCv
         PECO4u7/U18eYBZEg3I6LS8NOGatyNulfZc+VDRuSmtRIw16VaaYXlhWGPkjcyTRfaqI
         F4Tb1Pre7mmQklB3QLDqcbLUtosEjQoCg9r++s59253UVlr13D+XbqD1OAs8h4MljM2s
         XFL6HLnvZlSPKEGOMOf2Y/0hiEv49GR6Qcs+SiDbK2YD20xzEO8aDUvhPkQHZXB7iqfB
         ajVNj1QkCnPBIsL67kkzL1KXrPTTZ+F/ljpCguo3hXbZBGXJ7XcRTYz8F/wa2GbJP4cL
         Omhw==
X-Received: by 10.182.144.40 with SMTP id sj8mr3219545obb.82.1363368326642;
 Fri, 15 Mar 2013 10:25:26 -0700 (PDT)
Received: by 10.76.13.2 with HTTP; Fri, 15 Mar 2013 10:25:26 -0700 (PDT)
X-Originating-IP: [2.102.85.74]
In-Reply-To: <00107242-04EB-423F-90FE-A6DCDEE7E262@infoservices.in>
X-Gm-Message-State: ALoCoQnX8I0JGW9Fm+zYqLSVcLIOYY33AGnKn0GS0NC+Eqsjp9UW0kBKFn1ziUCw6iS489TL7N8d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218254>

On Fri, Mar 15, 2013 at 12:52 PM, Joydeep Bakshi
<joydeep.bakshi@infoservices.in> wrote:
>
> On 15-Mar-2013, at 6:14 PM, Fredrik Gustafsson <iveqy@iveqy.com> wrot=
e:
>
>> On Fri, Mar 15, 2013 at 05:54:05PM +0530, Joydeep Bakshi wrote:
>>> [1] the server will have different git repo with branches
>>> [2] there will be a web-based GUI which must be flexible to show ju=
st a specific branch of a repo based on user authentication
>>> [3] the web-based GUI should also have the flexibility to show a si=
ngle repo based on the authentication
>>> [4] the web-based GUI should have an admin account to supervise and=
 configure all repos along with their branches
>>> [3] there must be a control mechanism in the repo/web based GUI whi=
ch have ACL on branches i.e.
>>> some specific users should see some specific/ or just a branch and =
able to commit there only.
>>>
>>> based on the above scenario could anyone suggest the best available=
 solution ?
>>> There are many like gitolike/github etc=85. but don't know whig one=
 has much finer granular
>>> control/ACL/web-based GUI=85
>>
>> gitolite have a more fine ACL. Check it out. However it doesn't real=
ly
>> meet your needs with web-interface (and I'm not even sure about the =
ACL
>> thing is fine enough for you). You can read more about ACL in the gi=
t
>> book: http://git-scm.com/book/ch7-4.html
>>
>> The webgui that's most populair is cgit and git-web. They don't do A=
CL
>> afaik.
>>
>> Why would you need ACL? Why not don't share the branches that are go=
ing
>> to be secret? Or are you looking for some branches to be read only?
>
> Actually the branches have to be dedicated to a group of users.
>  developer branch ---> developers
> bug fixed branch --- > bug fixer
>
> and specific group don't need to RW permission on other branch.
> Obviously the admin must have the full permission on all these branch=
es
> and merge as per requirement.
>
> The web-interface is required for checking the history by the users t=
hemselves
> and for code review. I don't know any web interface which can show re=
po/branch
> based on authentication. I have tried gitweb but it can handle a sing=
le repo or multiple
> repo with single authentication. NO ACL

I think you would need to have a separate repo for each group. Then
only push the appropriate branches to each repo.

--=20
Paul [W] Campbell
