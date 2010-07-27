From: Tong Sun <suntong@cpan.org>
Subject: Re: Recommended work flow with git to send in patches
Date: Tue, 27 Jul 2010 11:43:02 -0400
Message-ID: <AANLkTikk_EZuGayD2yPqEhTyXS9YKHscwCF2NNjXwMdv@mail.gmail.com>
References: <AANLkTiksAOpFG3vGVGcbeZ0NcpQ5FbDjnZ7yDxUsAY_r@mail.gmail.com>
	<AANLkTin-x01FrFWLD04um8xwKeb6vUjpqlG0S7Xnk85j@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 27 17:43:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdmJF-0005Qy-CP
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 17:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752066Ab0G0PnG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 11:43:06 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:60792 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751173Ab0G0PnD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 11:43:03 -0400
Received: by pxi14 with SMTP id 14so500630pxi.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=4LET1do+OEPCZ3hc/NKr9wYvQuzOrF9DKvfLlLJqHsQ=;
        b=xP9pbYqjRVmJBPqKG2d9foSg+M+APN9BErqU2lV3KfiQ3V4PUegXzVy9vyWWcBhM4G
         WQEg2YkNJO7xFOUFyM+urBRoz/zKlJpC6QmbfNROHQKRNIWRrfs21gVQxnqeVJw+DwDo
         hSArU6VmN4M88nJJMWLWua6Y/sJoOwKbCqr0A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=Tnr5GjzC1wvy6klOrHaGsl4WNFwp2S8I9OOxSkmI7BAc+Yjc8tVD+LMIDb9hSz0ob2
         2og8IlcOydJq/xRAXvdfIPmojWKWNa39GRsHnm5z+JVH3QYsuIHyAG147+JsCL5ItEBG
         9fwYht76FkM1ujo/XBZhcPE0Zvo8vdBtPLBCY=
Received: by 10.114.132.13 with SMTP id f13mr683988wad.35.1280245382812; Tue, 
	27 Jul 2010 08:43:02 -0700 (PDT)
Received: by 10.114.130.11 with HTTP; Tue, 27 Jul 2010 08:43:02 -0700 (PDT)
In-Reply-To: <AANLkTin-x01FrFWLD04um8xwKeb6vUjpqlG0S7Xnk85j@mail.gmail.com>
X-Google-Sender-Auth: C6FtjgZG2b-rhJdocYBOfc3MGmo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151951>

On Tue, Jul 27, 2010 at 11:35 AM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> On Tue, Jul 27, 2010 at 15:31, Tong Sun <suntong@cpan.org> wrote:
>> - work on the code, commit, hack, commit, hack, commit -- commit oft=
en
>> & commit small
>
> So far so good.
>
>> - when AOK and need to integrate patches into main branch, squash al=
l
>> patches into one
>
> That's just silly. Why is the policy to destroy commit information
> when submitting patches?

Sorry about the confusing. The original message was composed under the
condition that all patches are relevant patches that work together to
form a big logical changes. I was required to do the squashing.

thanks
