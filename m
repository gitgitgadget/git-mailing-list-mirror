From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv3] git apply: option to ignore whitespace differences
Date: Wed, 29 Jul 2009 11:09:12 +0200
Message-ID: <cb7bb73a0907290209u11b2055bv9889ccd5c4a92911@mail.gmail.com>
References: <1248814820-25367-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vljm84htf.fsf@alter.siamese.dyndns.org> <cb7bb73a0907282333g26efd1d8y7d913fba8a426aa5@mail.gmail.com> 
	<20090729174000.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 11:10:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MW5B1-0002xL-8I
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 11:10:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbZG2JJe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 05:09:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751907AbZG2JJd
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 05:09:33 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:52686 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752960AbZG2JJd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 05:09:33 -0400
Received: by fxm18 with SMTP id 18so255438fxm.37
        for <git@vger.kernel.org>; Wed, 29 Jul 2009 02:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=10yNpwGh1TDJttWO6yZCf2xiuOL5sHAfsTlV9imp3M8=;
        b=B1RXP9lCXm8+iJ94GXLByPhpEgtAhdOBX/AYISHLhLIZ4LK6Y2o50alihk5gAxrSOf
         q/xXQRZ4drwykTTfLLsbnVNCMITN9KT+5ZOI8iBCTlQ2JSvU7WnWbuo8zBd44tIpvN8g
         NORrqVIwu4tOkrhX+DNiwe0saaDmrWOBZE7YU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=TtOc1WYsYVlImLsBNmpypD4ttHVSggYM4Ohyw3zjBsjETp1ZV5H57HHyrG7b9tzd07
         w3xQaJrMFKn4NGciGJgONZHa3k0rdqgJlbhHwH7p0GnjOKQKwc1EQhi+tdCEpwcPFP1W
         eicPqbAYE86CK97FoTjVPEJy0m6FNiccx4eAI=
Received: by 10.204.119.129 with SMTP id z1mr5365963bkq.67.1248858572078; Wed, 
	29 Jul 2009 02:09:32 -0700 (PDT)
In-Reply-To: <20090729174000.6117@nanako3.lavabit.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124334>

On Wed, Jul 29, 2009 at 10:40 AM, Nanako Shiraishi<nanako3@lavabit.com> wrote:
> Quoting Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
>
>>> Perhaps --ignore-space-change, to be consistent with a "git diff" option,
>>> would be more appropriate. Doing so has an added benefit of leaving the
>>> door open to add --ignore-all-space option to the patch application side
>>> later.
>>
>> On the other hand, --ignore-whitespace matches the option name (and
>> behavior) of the 'patch' command (just like "git diff"'s matches the
>> 'diff' option name and behavior). Principle of least surprise says
>> that someone coming to git from raw diff/patch setups would expect
>> --ignore-whitespace on the patch side.
>
> Not everybody shares your diff/patch background.
>
> I wouldn't be surprised if git were the first system they ever learn for
> majority of users of version control systems in this century, especially
> because now there are many books written on it.

This is something I hadn't considered.

> Isn't it more important for git to be internally consistent across its
> commands for such an audience to satisfy the principle of least surprise?

Would it be ok if I had the option and command line option turn into
ignore-space-change and keep ignore-whitespace as a synonym? Or would
that be too much?

-- 
Giuseppe "Oblomov" Bilotta
