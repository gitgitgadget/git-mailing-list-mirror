From: Daniel Mack <zonque@gmail.com>
Subject: Re: Suppressing auto-cc for specific addresses
Date: Mon, 8 Aug 2011 12:58:55 +0200
Message-ID: <CACTFLAN0gM-xvEU32KHEsaApH4apvGUwGkiDHx06PngHUvH0Ew@mail.gmail.com>
References: <4E3EF38A.9010307@gmail.com>
	<20110807234634.GA3236@kroah.com>
	<CACTFLAOhApGVNZ7JsWhoHBEaQ_87stXjxkXvadmauNfhSuPD1g@mail.gmail.com>
	<D95ADFD4-2504-4BE6-BCD4-7B916F6F2FEB@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Greg KH <greg@kroah.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 08 12:59:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QqNY7-00031O-Sy
	for gcvg-git-2@lo.gmane.org; Mon, 08 Aug 2011 12:59:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751864Ab1HHK66 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Aug 2011 06:58:58 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:41570 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751023Ab1HHK6z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2011 06:58:55 -0400
Received: by pzk37 with SMTP id 37so8127356pzk.1
        for <git@vger.kernel.org>; Mon, 08 Aug 2011 03:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=XFw3pA4SFKLEtcZjdxkBd9Xf9oE4zEFTyPtRcPcTDzM=;
        b=kAhyT70AYt6Yqo8PVNDXfWXM5B5rCr5edA3yAKtuTro2kfz41Dg9C6Va+G2/9WUgCL
         gKkS7d36cyPZWiniSof9CHg7HFPmQY5NZMZZ8kImx9GtITZ0yll35T8vKKLOJ+5pnFff
         PnUK71GcW8nHI7Bl05i0GVEDRPz5p39BfCuoU=
Received: by 10.142.48.10 with SMTP id v10mr5774303wfv.185.1312801135061; Mon,
 08 Aug 2011 03:58:55 -0700 (PDT)
Received: by 10.142.194.11 with HTTP; Mon, 8 Aug 2011 03:58:55 -0700 (PDT)
In-Reply-To: <D95ADFD4-2504-4BE6-BCD4-7B916F6F2FEB@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178954>

On Mon, Aug 8, 2011 at 12:56 PM, David Aguilar <davvid@gmail.com> wrote=
:
> git send-email has a=A0--[no-]signed-off-by-cc option and configurati=
on
> variable.=A0--

I know, but that's not the point. It about having a certain address
metioned in a ^Cc: line inside the patch and suppress sending off
emails to that specific address. And --suppress-cc currently only
allows categories to be set, not addresses.


Daniel
