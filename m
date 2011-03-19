From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 1/2] gitweb: rename parse_date() to format_date()
Date: Sat, 19 Mar 2011 22:50:46 +1100
Message-ID: <AANLkTi=rRjGi6y73G-GqextdJ-oLmTgZASTGvoZU-CPE@mail.gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost>
	<201103191134.00098.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Cernekee <cernekee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 12:51:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0ugR-00038P-7B
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 12:51:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480Ab1CSLus convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 07:50:48 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:50168 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751465Ab1CSLur convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2011 07:50:47 -0400
Received: by iwn34 with SMTP id 34so4870127iwn.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 04:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gKjkmGxYhhRlMy8t0Ilk9qyee661SUgiHWQiHE2gSko=;
        b=iccjLdiXBzCx7NiW8JJd4Ambl4Gc+cZy+LUWZGPVHpL07Qkj5pvAKRgsB2V8DFr7vK
         8+mk5f6QvzjKarCPvosVQzp1IO2ZhErosVpfsVXXT0ucM3IJGjLC2IvuLJQ+v1koI6tV
         PRNNcHcXtspiNRANZDldNtRyE1ORByoyW5NxA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kji4kGs2NPplN7+RTzOVNkczpKd4709GbK7vl7q3dD3Mopq8iXZgqCjT2SQOM6+X18
         5CaZFvVkNDjjGB+gfQkZNCK16/adOCcjuQJZuiW63lniANYgSrciBU24xIniuy13ljpR
         Exw+D+6xFpjOW62epxtYyNuv25hTqhSbE/a3k=
Received: by 10.42.156.199 with SMTP id a7mr3170533icx.417.1300535446521; Sat,
 19 Mar 2011 04:50:46 -0700 (PDT)
Received: by 10.42.195.138 with HTTP; Sat, 19 Mar 2011 04:50:46 -0700 (PDT)
In-Reply-To: <201103191134.00098.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169425>

On Sat, Mar 19, 2011 at 9:33 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> On Sat, 19 Mar 2011, Kevin Cernekee wrote:
>
> =C2=A0- formatted_date
> =C2=A0- process_date, process_raw_date, process_git_date
> =C2=A0- process_epoch, process_timestamp
> =C2=A0- date_formats
> =C2=A0- from_epoch, date_from_epoch
>

How about: decompose_date?

jon.
