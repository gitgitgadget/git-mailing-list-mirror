From: Elijah Newren <newren@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2010, #01; Wed, 1)
Date: Sat, 4 Sep 2010 21:05:51 -0600
Message-ID: <AANLkTimMbTNSgaep-hQ5NObgNMVNk76FmJSbCy7+B6i5@mail.gmail.com>
References: <7vaao15jk2.fsf@alter.siamese.dyndns.org>
	<AANLkTi=ma8MLssD_1YeSju7iJucRN9NFzYESJ2rGhyjv@mail.gmail.com>
	<AANLkTik7eBGJrQ3HEYjesvR9y1PpwUphVvpBmzVCiu6p@mail.gmail.com>
	<AANLkTik=81_ma6iZLJ1RQJ74o1g7dNN2GfT6bTT+hQti@mail.gmail.com>
	<AANLkTinoegtf1G2FxfT_vvQRRMMuyNMc7zM5SY8oG_rY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 05:06:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Os5YX-0006A5-BA
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 05:06:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858Ab0IEDFx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 4 Sep 2010 23:05:53 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:53970 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750897Ab0IEDFx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 4 Sep 2010 23:05:53 -0400
Received: by fxm13 with SMTP id 13so1991462fxm.19
        for <git@vger.kernel.org>; Sat, 04 Sep 2010 20:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=6zIwO0iGwycesou1K0pQlH3nRmiTyDF/5WfzW0G9exs=;
        b=CgLeOjeya3xb30TqyrVY7O7LvVpAJ4hfdML0wF5x7YP7gza5tibdJod7uHtMnoi8CT
         D6s4jTySXlgOjvqcSLOcirPKHRVHcKUui76sMZSYZiP/qY6wTL+kBaNpPYT1i6+a7QIB
         fbuNOrn7K5Q8MpZsZTm8uHWly4EmS1217mJF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=h/vOrqWF1VhPzIm54yXUZ7ehcPmNQsSzzPf94zQF3xA1UFb1yI2Ti4Z3kNOzgeP0CG
         3/bXVwTTRvRJFAmqdxVzVqqVevwaaidrtxxfDBuv+qaK8y4fp1G0mqGmUp5B4w8+/CqB
         RLOQ/ImAxwbrTDE/gAlMH867vWcOx1ciOnzT4=
Received: by 10.223.119.147 with SMTP id z19mr1411636faq.4.1283655951782; Sat,
 04 Sep 2010 20:05:51 -0700 (PDT)
Received: by 10.223.50.154 with HTTP; Sat, 4 Sep 2010 20:05:51 -0700 (PDT)
In-Reply-To: <AANLkTinoegtf1G2FxfT_vvQRRMMuyNMc7zM5SY8oG_rY@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155414>

On Sat, Sep 4, 2010 at 8:14 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com=
> wrote:
> On Sun, Sep 5, 2010 at 9:48 AM, Elijah Newren <newren@gmail.com> wrot=
e:
>> On Wed, Sep 1, 2010 at 5:39 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.=
com> wrote:
>>> While at there, how about adding tree exclusion mechanism that you
>>> mentioned in sparse clone? That would be really cool.
>>
>> Tree exclusion or commit exclusion? =C2=A0I think I have the former =
working
>> (I'll post a patch series soon), but not the latter yet.
>>
>
> Yeah.. I'm looking at it now. By tree exclusion, I meant negative
> pathspec. Something like "traverse anything in 't' except t/t9700". I
> can see you are getting real close to that.

Ah, nope, I haven't tackled that at all and hadn't planned to anytime s=
oon.
