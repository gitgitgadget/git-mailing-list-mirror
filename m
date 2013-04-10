From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH] glossary: extend "detached HEAD" description
Date: Wed, 10 Apr 2013 20:29:08 +0200
Message-ID: <5165AF74.9060508@gmail.com>
References: <7vwqshc8ec.fsf@alter.siamese.dyndns.org> <5165623C.703@gmail.com> <7vfvyyo35x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?B?Q2FybG9zIE1hcnTDrW4gTmlldG8=?= <cmn@elego.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 20:29:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPzln-0002Zi-TM
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 20:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936246Ab3DJS3O convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 14:29:14 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:62982 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933289Ab3DJS3N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 14:29:13 -0400
Received: by mail-ee0-f47.google.com with SMTP id t10so378054eei.34
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 11:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=Jlk3jcgC8gmEA5naa4sPRflJRV8H9/ARoh9MHvQvLos=;
        b=FUKtZ2CWDkigF08IVsOkkEB9Yq/mB9Ie0n7uDwuStFpITNqVbxt+sWxkFcxiO9nPM+
         WmgpMYV2saT6WsD678rEx7EW++B7eVfSJSGFQkj9vmOxcbVrwLj+esYovQn9sgkEc2ai
         /NdJ5tk7V6f71LixzoNEVIhzc82WguLC9C4K6IV5RfLdixq+uUz29LV5fB13vKAWQQxm
         X9o/4KD0XTLUW3S4JwNU3qmotps8AROARvUEtOumWvPN24cqcc6Eu6M9MwRvRTPT+kLX
         /Ed1d7WwOK8fjDukKIEnHRwmaM3MgftRTJYjp7ut0GZ6hZG6J1clxqUMnSHC3xSabeS6
         HrhA==
X-Received: by 10.14.202.71 with SMTP id c47mr7877738eeo.39.1365618551659;
        Wed, 10 Apr 2013 11:29:11 -0700 (PDT)
Received: from [192.168.1.14] (edx151.neoplus.adsl.tpnet.pl. [83.21.9.151])
        by mx.google.com with ESMTPS id ca4sm1225883eeb.15.2013.04.10.11.29.09
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 10 Apr 2013 11:29:10 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130329 Thunderbird/17.0.5
In-Reply-To: <7vfvyyo35x.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220716>

W dniu 10.04.2013 16:45, Junio C Hamano pisze:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
>> Junio C Hamano wrote:
>>
>>> diff --git a/Documentation/glossary-content.txt b/Documentation/glo=
ssary-content.txt
>>> index f928b57..69c90d1 100644
>>> --- a/Documentation/glossary-content.txt
>>> +++ b/Documentation/glossary-content.txt
>>> @@ -100,9 +100,22 @@ to point at the new commit.
>>> =20
>>>  [[def_detached_HEAD]]detached HEAD::
>>>  	Normally the <<def_HEAD,HEAD>> stores the name of a
>>> -	<<def_branch,branch>>.  However, git also allows you to <<def_che=
ckout,check out>>
>>> -	an arbitrary <<def_commit,commit>> that isn't necessarily the tip=
 of any
>>> -	particular branch.  In this case HEAD is said to be "detached".
>>> +	<<def_branch,branch>>, and commands that operate on the
>>> +	history HEAD represents operate on the history leading to the
>>> +	tip of the branch the HEAD points at.  However, Git also
>>> +	allows you to <<def_checkout,check out>> an arbitrary
>>> +	<<def_commit,commit>> that isn't necessarily the tip of any
>>> +	particular branch.  The HEAD in such a state is called
>>> +	"detached".
>>
>> Should we also add that "git branch" output shows this situation
>> as "(no branch)"?
>>
>> Nb. this is not documented in git-branch(1) manpage either...
>=20
> Sounds good. Please make it so, perhaps for both.

Err... I can try to add such documentation in git-branch(1), but
shouldn't I wait for your changes to glossary before adding info
about "(no branch)"?

P.S. From some StackOverflow questions the connection between "(no
branch)" and detached HEAD is not clear for git newbies...
--=20
Jakub Nar=C4=99bski
