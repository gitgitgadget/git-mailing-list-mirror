From: "Tomi Pakarinen" <tomi.pakarinen@gmail.com>
Subject: Re: [EGIT PATCH] git property page for project properties.
Date: Tue, 21 Oct 2008 21:09:13 +0300
Message-ID: <f299b4f30810211109q7f2919f2r1d5cd8faf0048154@mail.gmail.com>
References: <1224529604-42397-1-git-send-email-tomi.pakarinen@iki.fi>
	 <200810211950.50540.robin.rosenberg.lists@dewire.com>
Reply-To: tomi.pakarinen@iki.fi
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spearce@spearce.org, git@vger.kernel.org
To: "Robin Rosenberg" <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Oct 21 20:11:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsLgs-0001yk-Cv
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 20:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751814AbYJUSJQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 14:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752084AbYJUSJP
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 14:09:15 -0400
Received: from wa-out-1112.google.com ([209.85.146.180]:57542 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752676AbYJUSJO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Oct 2008 14:09:14 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1263049wah.21
        for <git@vger.kernel.org>; Tue, 21 Oct 2008 11:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:reply-to
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=kteBD0DMjSDmdlMiLnVlUQJvW9a74OlKhW5N8QFfUQw=;
        b=Q8XTy9NKF8I7B+m0OYy0iUWC0SBbx3nqJjF5yYicm4BnY9pwZjVXpzbXhU8JrkV6Pr
         39+B03DOUhrW47e3WHKLMPVRvvUjvP3GAhpDgdbaibHsVF13lY+SRWYH7yVBuA96xfEi
         seHSOdinK9xfmyP1qrmRtBBGDBzeReE+2IowU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:reply-to:to:subject:cc:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:references;
        b=ukBD+YXpomEbQuafmmFAsdjg1PDru62ddyz4MbNy1BK9XnjLgvldoqX4hZmKPHtwIw
         TyTBmPIilqYWixLSge1CKhvpw6Is5GiP9/szmYpJ27irkWsv1x6T2UVS64gm482DonHf
         eOeda0kE+bVnlqA+etj+Veize/OIVh5BA2dw4=
Received: by 10.114.37.1 with SMTP id k1mr6687821wak.42.1224612554076;
        Tue, 21 Oct 2008 11:09:14 -0700 (PDT)
Received: by 10.115.91.4 with HTTP; Tue, 21 Oct 2008 11:09:13 -0700 (PDT)
In-Reply-To: <200810211950.50540.robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98801>

On Tue, Oct 21, 2008 at 8:50 PM, Robin Rosenberg
<robin.rosenberg.lists@dewire.com> wrote:
> m=E5ndagen den 20 oktober 2008 21.06.44 skrev Tomi Pakarinen:
>>  Show git property page in project's properties, if project
>> has git repository provider.
> [...]
>> +             switch (repository.getRepositoryState()) {
>> +             case BISECTING:
>> +                     state.setText("Bisecting");
>> +                     break;
>> +             case MERGING:
>> +                     state.setText("Merging");
>> +                     break;
>> +             case REBASING:
>> +                     state.setText("Rebasing");
>> +                     break;
>> +             case REBASING_INTERACTIVE:
>> +                     state.setText("Rebasing interactive");
>> +                     break;
>> +             case REBASING_MERGE:
>> +                     state.setText("Rebasing merge");
>> +                     break;
>> +             case SAFE:
>> +                     state.setText("Safe");
>> +                     break;
>> +             }
> Why not this:
>
>                state.setText(repository.getRepositoryState().getDescr=
iption());
>
> Description is ment for presentation purposes. The enum for code.
>
> -- robin
>

 That is ok. I just didn't notice that method before. But, what if
someone wants localize this plugin, he'll propably have to explode
this back to switch statement.

   Tomi.
