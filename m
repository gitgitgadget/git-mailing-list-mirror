From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [RFC/PATCH] parse-options: introduce parse_subcommands
Date: Wed, 6 Jun 2012 19:40:39 +0530
Message-ID: <CALkWK0nuJ2VrAUD5PsfnZzO5yDgB+h4xn8g=CTqmUvJ8DOdPNQ@mail.gmail.com>
References: <1338802534-32394-1-git-send-email-artagnon@gmail.com> <7vlik3t3j2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 06 16:11:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScGx2-00057e-OZ
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jun 2012 16:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755447Ab2FFOLC convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jun 2012 10:11:02 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41645 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754815Ab2FFOLB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jun 2012 10:11:01 -0400
Received: by wgbdr13 with SMTP id dr13so6265332wgb.1
        for <git@vger.kernel.org>; Wed, 06 Jun 2012 07:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=i6SyH9CZT5m60dyIuG2gGE098oyDExq0fLRiO6fE3yY=;
        b=eDQV73+2Wm0Rz6vat3cwNnoiiE77GDBCNCytxXPCqF1ihE2qCQkRJSBV+7bZ3bCoQv
         Buf3yirRlX9qu1mVI5WBmP8NSirpuutaILodPFOhhRVkElDJazkN/DF8aXmcxWErmugf
         pQKB5xteT/bgrfG/nqGmqKOOvssffUY82SlkWG4WPy69EFDZFLV0szHwaxdWpb8F2Vgm
         qJSzxU7pvp9kKo2gkP8kSiejNYZpYg5sfbh4pOwFN8jlgrMQCkH0UJfUvFJL9MFpCAF6
         4O99BHbuAB1h8Bxom7VFz+cV2Z6BwcOK4XGeAZlpN4xL9qFEEaw+9EeL7ke2FvPsCCcW
         vLbA==
Received: by 10.216.194.137 with SMTP id m9mr17513992wen.66.1338991859812;
 Wed, 06 Jun 2012 07:10:59 -0700 (PDT)
Received: by 10.216.160.9 with HTTP; Wed, 6 Jun 2012 07:10:39 -0700 (PDT)
In-Reply-To: <7vlik3t3j2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199334>

Hi Junio,

Junio C Hamano wrote:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> =C2=A0I found this patch in one of my branches from a long time ago.=
 =C2=A0I
>> =C2=A0haven't written documentation and tests yet because I'm not fu=
lly
>> =C2=A0convinced that I like this.
>>
>> =C2=A0Thoughts?
>
> It looks like a static version of string_list_lookup() and does not
> have much reason to tie it to "subcommand".

How so?  I can use a string_list to keep subcommand->name and stuff
the callback into util.  Where do I put subcommand->help then?
I agree that there's no reason to tie it to subcommand though.

Ram
