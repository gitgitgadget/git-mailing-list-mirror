From: Roy Lee <roylee17@gmail.com>
Subject: Re: Does cloning a shallow repo require special setting in the cloned 
	one?
Date: Thu, 26 Feb 2009 15:33:30 +0800
Message-ID: <6eac7f470902252333x6326419bq305da3436cff3aa7@mail.gmail.com>
References: <1235620146513-2387799.post@n2.nabble.com> <87tz6hn1tg.fsf@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Feb 26 08:35:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lcaln-0008AB-G7
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 08:34:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbZBZHdd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Feb 2009 02:33:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751645AbZBZHdc
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 02:33:32 -0500
Received: from rv-out-0506.google.com ([209.85.198.231]:61024 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311AbZBZHdc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Feb 2009 02:33:32 -0500
Received: by rv-out-0506.google.com with SMTP id g37so418041rvb.1
        for <git@vger.kernel.org>; Wed, 25 Feb 2009 23:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=LkgZ35ze7njSfG0152wjqgOd1hcBRpCrm+nx32MrGDU=;
        b=e3EajPbzyMrigr7xJrR1crpb9TS5GB/qul71awXXO0w5d3yY3ACy7k0kjuMm3x6xzo
         groUvhzx/5+YilB18gDOyN6Bsa5XZ6I1MvvYohXmzVZR1P24ehcgL4Klnq5PGRUezClS
         CD2c1vpoE0LO1pNTt197TvYMYshIBDvBx2Lko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=jL0lGWtd2Im6n343hcODusXOg2zuLU4OUP16Vhocn/HwYoWDYGR9Nohm8o1dqWVi90
         VEBNexriWCN0mZo2iLd3UDkH4+GC3VWz+R0tT5WhOBSVRG50gwhVH/6/7mAoNk/R+lxk
         +I8sYq6K3jF/gjsCpb5WsVBubM1HLDJHF3jU4=
Received: by 10.141.115.20 with SMTP id s20mr495977rvm.70.1235633610207; Wed, 
	25 Feb 2009 23:33:30 -0800 (PST)
In-Reply-To: <87tz6hn1tg.fsf@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111538>

On Thu, Feb 26, 2009 at 2:34 PM, Teemu Likonen <tlikonen@iki.fi> wrote:
> On 2009-02-25 19:49 (-0800), roylee17 wrote:
>
>> $ git clone --depth 1 git-full git-shallow2
>> 'git log' still gives a full history
>>
>> Why can't I clone a shallow repo from the git-full?
>> Does it requires some settings in the git-full repo?
>
> I don't know the "why" part but using file:// URL should work:
>
> =A0 =A0git clone --depth 1 file:///path/to/git-full git-shallow2
>

Thanks, Teemu. file:///path/to/git-full works.
