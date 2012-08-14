From: David Michael Barr <davidbarr@google.com>
Subject: Re: [PATCH/RFC v3 00/16] GSOC remote-svn
Date: Wed, 15 Aug 2012 09:59:12 +1000
Message-ID: <CAFfmPPO4FRBocLDZr8WU2GJOTVXFY6+8jjO8mEoL+aRPtp6k2Q@mail.gmail.com>
References: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 15 01:59:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1R16-0003HF-4W
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 01:59:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754613Ab2HNX7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 19:59:13 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:62212 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754238Ab2HNX7M (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 19:59:12 -0400
Received: by obbuo13 with SMTP id uo13so1294144obb.19
        for <git@vger.kernel.org>; Tue, 14 Aug 2012 16:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=txG+OCjKXpnJxuHBQJOw22vybeBsscLhATf0LweiwVg=;
        b=Gnlh4r2y1RpZNGLjjx3y4BHitgQKfGv3jv5ejNM2Z6OlyHryYijrV7yDp7F7y/sfbO
         sp1Fauq6P1Q1KQV+SJurTS31P+MfmVnRGjXX4ADSjEyhmk4wNiMpbAMr1w1shOh7KuU6
         LSUWeXvo+B3auuOwpyORE83diRrX/FqR+BfINL56g93QL3FZtvRZFJXhcw7lLgi/OGfx
         F9Wc3yjBM2qxncOSgQYd0uH913DnFAo6IYU3r5ezl3QVd40mKQhFNyflReFgqZIcPEdn
         6nZXiEwedxYOrC7Rx4Z/JDaWSLc5bXkmAHlVvj3aUlpajhYeVCByk4Mfeuw2a4yETr35
         A4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=txG+OCjKXpnJxuHBQJOw22vybeBsscLhATf0LweiwVg=;
        b=Dx7VPVwc/FvxxbHH5YTq+uCyDIyYlyWB/cIekUE94VXZvfm1eLKytzRl2Fb1vEHEXj
         O8c4mD/mnbXuqlcRc88xo1GukyzsKRovF4nGuMu98PIfO8jy+oE49Gb0X0o9FCGu+h2+
         9zA7hYbQQhyuLXIT66L8mdZ1bIDi7IT9KJyb7puYS/6yVALG99tzWE1iUUurPKbOxRVg
         9koweHF2xSMYmyXY8zo3QShJdRRy6kgNfrGrfoUJzNK75KQG6viNoS3GMdcXcGJl6r6L
         DsZu27CzjTvt+bu6QJxiqK3083p3as9HkvCrDC6AkVS+/8px7KPP4y2K806skyxSfNjP
         yGqA==
Received: by 10.60.20.74 with SMTP id l10mr29211554oee.19.1344988752310;
        Tue, 14 Aug 2012 16:59:12 -0700 (PDT)
Received: by 10.60.20.74 with SMTP id l10mr29211539oee.19.1344988752131; Tue,
 14 Aug 2012 16:59:12 -0700 (PDT)
Received: by 10.76.141.1 with HTTP; Tue, 14 Aug 2012 16:59:12 -0700 (PDT)
In-Reply-To: <1344971598-8213-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQmZacjy6/MoKcRExftJxibKklfBlLyUaR5e3wwAjbV9BMqNFOAeJ7iOODXwzrh3z0L+rYY9bs9dTJdik1DHJJtHBD14SQfPQev6pbJF7DeOHD8sGpUbOE/gUPE0iBHU+JWhap0MHHUywu4M4ay8Co2gzzFrwGrLRGaJDQ9Rwt/G92/b5e9AAeFPiCODKYb9qLPLNN5t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203460>

On Wed, Aug 15, 2012 at 5:13 AM, Florian Achleitner
<florian.achleitner.2.6.31@gmail.com> wrote:
> Hi.
>
> Version 3 of this series adds the 'bidi-import' capability, as suggested
> Jonathan.
> Diff details are attached to the patches.
> 04 and 05 are completely new.
>
> [PATCH/RFC v3 01/16] Implement a remote helper for svn in C.
> [PATCH/RFC v3 02/16] Integrate remote-svn into svn-fe/Makefile.
> [PATCH/RFC v3 03/16] Add svndump_init_fd to allow reading dumps from
> [PATCH/RFC v3 04/16] Connect fast-import to the remote-helper via
> [PATCH/RFC v3 05/16] Add documentation for the 'bidi-import'
> [PATCH/RFC v3 06/16] remote-svn, vcs-svn: Enable fetching to private
> [PATCH/RFC v3 07/16] Add a symlink 'git-remote-svn' in base dir.
> [PATCH/RFC v3 08/16] Allow reading svn dumps from files via file://
> [PATCH/RFC v3 09/16] vcs-svn: add fast_export_note to create notes
> [PATCH/RFC v3 10/16] Create a note for every imported commit
> [PATCH/RFC v3 11/16] When debug==1, start fast-import with "--stats"
> [PATCH/RFC v3 12/16] remote-svn: add incremental import.
> [PATCH/RFC v3 13/16] Add a svnrdump-simulator replaying a dump file
> [PATCH/RFC v3 14/16] transport-helper: add import|export-marks to
> [PATCH/RFC v3 15/16] remote-svn: add marks-file regeneration.
> [PATCH/RFC v3 16/16] Add a test script for remote-svn.

Thank you Florian, this series was a great read. My apologies for the
limited interaction over the course of summer. You have done well and
engaged with the community to produce this result.

Thank you Jonathan for the persistent reviews. No doubt they have
contributed to the quality of the series.

Thank you Junio for your dedication to reviewing the traffic on this
mailing list.

I will no longer be reachable on this address after Friday.

I hope to make future contributions with the identity:
David Michael Barr <b@rr-dav.id.au>
This will be my persistent address.

--
David Barr
