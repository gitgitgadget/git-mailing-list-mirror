From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2 2/3] git-remote-fd
Date: Thu, 30 Sep 2010 12:04:31 +0000
Message-ID: <AANLkTimegoGAV3vVbOVnNLLcMjuPh6dK33siRxNoWRmM@mail.gmail.com>
References: <1285847579-21954-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<1285847579-21954-3-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Thu Sep 30 14:04:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P1HsN-0008Sp-FV
	for gcvg-git-2@lo.gmane.org; Thu, 30 Sep 2010 14:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753947Ab0I3MEd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Sep 2010 08:04:33 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64391 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750949Ab0I3MEc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Sep 2010 08:04:32 -0400
Received: by iwn5 with SMTP id 5so2362463iwn.19
        for <git@vger.kernel.org>; Thu, 30 Sep 2010 05:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dPzrucjBnmmNsDbsvt6dDuGuG8bU3AJPzbExms1u8fM=;
        b=BFQX0pkWH8SA5D3fQObaEU9AUnzEqgU8sHyomexdEcsCcj114svVGWbeYuGHdISAml
         jVQEakZSCX+LlbYBv6dIiYrJCfXBmPzmu/vnPmS1sbyv1PHtOXFIghDaqL1B4Eqtynbu
         ejhOYBemnjcQjIymusLp0ycYjjP9SYbMfBopA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gMOGWyXx8fXbUc1bCSYyVZCsVFhCI+IMhPKTfDI1q9qeCIcDI7TuXyEarrdhKAJ5Vw
         5V98DsO4Z4nS2rx3jByzc06N5uk0UT2luBJIQFov8mH2quEuIKY8cFt2rJOUsgPCUBDr
         frVpE/Thgq6S31PDPBrLt4fIUg0LGE6NF8jYA=
Received: by 10.231.187.194 with SMTP id cx2mr2471659ibb.165.1285848271860;
 Thu, 30 Sep 2010 05:04:31 -0700 (PDT)
Received: by 10.231.48.195 with HTTP; Thu, 30 Sep 2010 05:04:31 -0700 (PDT)
In-Reply-To: <1285847579-21954-3-git-send-email-ilari.liusvaara@elisanet.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157647>

On Thu, Sep 30, 2010 at 11:52, Ilari Liusvaara
<ilari.liusvaara@elisanet.fi> wrote:

> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 //Strip end of lin=
e characters.

Don't use a C++/C99 comment.
