From: Alexey Zakhlestin <indeyets@gmail.com>
Subject: Re: "git pull" doesn't respect --work-tree parameter
Date: Wed, 22 Dec 2010 14:50:03 +0300
Message-ID: <AANLkTi=JrOe=z4LNZtxfsDvkG2jYCtemYESftv=61ZrJ@mail.gmail.com>
References: <AANLkTi=UtZuPQcTNnwS_fXgzRn4MHAUGS8zyTMqX9E2J@mail.gmail.com>
	<AANLkTik9s0cLc_P=NWvpO=DhytOkLNASEM7sjzoscHo3@mail.gmail.com>
	<AANLkTinGPJRQCOVz5JeqL4xnUG9V=5fkJhz6C5Mi1A3o@mail.gmail.com>
	<AANLkTimM9Ah+D6uYnOuZDjYzKfN2-YVArOAwegO9dbSD@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 22 12:50:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PVNCu-0000Sm-NB
	for gcvg-git-2@lo.gmane.org; Wed, 22 Dec 2010 12:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105Ab0LVLuF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Dec 2010 06:50:05 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:39431 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751531Ab0LVLuE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Dec 2010 06:50:04 -0500
Received: by iwn9 with SMTP id 9so5146146iwn.19
        for <git@vger.kernel.org>; Wed, 22 Dec 2010 03:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=UIGEem6CQygEd/nyC7dfC7g0nqMam2tBfwsTK69w9iI=;
        b=KzTwrUCgweobx46vOv8hGO3gl5fXla03E12EnVt6uD1fC3NynNt2+5tBEwwF4+NDwu
         cckZe8kGUrwoYi8k6Mne35G4e+KpoO4eDE7S1HcUIHEzmsT1oxaPmNOlxVLaUYA329Hr
         BYiufLvkQMNRPFEXwpqssE4d5mvmfWr5Pb1QU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=kw8YIywRJrLYaOQlXgvaOAJaRHo9T6/WEJqDrydrDEc2RWACIizReSvLwkqD7gza+J
         s1Nekop8lW8BYGRA0J4eNlTqTxUNIHOuRpocStoGv9R6DpMdu7Yyo1Mmpz+XKQRUIQR8
         EsU8pfq76PeFaIq27HwpAOPZ4vJskoottDCc0=
Received: by 10.231.31.139 with SMTP id y11mr6620954ibc.96.1293018603333; Wed,
 22 Dec 2010 03:50:03 -0800 (PST)
Received: by 10.231.11.133 with HTTP; Wed, 22 Dec 2010 03:50:03 -0800 (PST)
In-Reply-To: <AANLkTimM9Ah+D6uYnOuZDjYzKfN2-YVArOAwegO9dbSD@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164082>

On Wed, Dec 22, 2010 at 2:44 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Wed, Dec 22, 2010 at 6:40 PM, Alexey Zakhlestin <indeyets@gmail.com> wrote:
>> On Wed, Dec 22, 2010 at 2:20 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
>>> On Tue, Dec 21, 2010 at 11:04 PM, Alexey Zakhlestin <indeyets@gmail.com> wrote:
>>>> I am trying to use the following command:
>>>>
>>>> git '--git-dir=/path/to/repository/.git' '--work-tree=/path/to/repository' pull
>>>>
>>>> and get this error:
>>>> "git-pull cannot be used without a working tree"
>>>
>>> It works fine for me. What's the result of
>>>
>>> git '--git-dir=/path/to/repository/.git'
>>> '--work-tree=/path/to/repository' --git-dir
>>
>> No directory given for --git-dir.
>>
>>> git '--git-dir=/path/to/repository/.git'
>>> '--work-tree=/path/to/repository' --is-inside-work-tree
>>
>> Unknown option: --is-inside-work-tree
>>
>>> git '--git-dir=/path/to/repository/.git'
>>> '--work-tree=/path/to/repository' --show-toplevel
>>
>> Unknown option: --show-toplevel
>
> Sorry I forgot the command name (rev-parse). The full command should
> be "git --git-dir=... --work-tree=... rev-parse <option>" where option
> is --git-dir, --is-inside-work-tree, --show-toplevel. Can you please
> try again?

1) returns correct path:
/Users/indy/Documents/Sources/_mine/midgard/mvc/_rdf/midgardmvc_core/.git
2) false
3) returns correct path, again:
/Users/indy/Documents/Sources/_mine/midgard/mvc/_rdf/midgardmvc_core

just to make myself clear: $PWD is another path, not related to repository path

-- 
Alexey Zakhlestin, http://twitter.com/jimi_dini
http://www.milkfarmsoft.com/
