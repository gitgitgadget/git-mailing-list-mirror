From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] Documentation/SubmittingPatches: Explain the rationale
 of git notes
Date: Tue, 30 Dec 2014 18:30:30 -0500
Message-ID: <20141230233030.GA6344@flurp.local>
References: <1419907630-20146-1-git-send-email-sbeller@google.com>
 <CAGZ79kZcnu4ArwfEVNMh+mQjkYAvj=rJXP4jz2o6YF1t5=SQ6w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitter@pobox.com>, git@vger.kernel.org
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Dec 31 00:30:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y66FQ-0007Pu-Uz
	for gcvg-git-2@plane.gmane.org; Wed, 31 Dec 2014 00:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbaL3Xak (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2014 18:30:40 -0500
Received: from mail-ig0-f179.google.com ([209.85.213.179]:64917 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbaL3Xak (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2014 18:30:40 -0500
Received: by mail-ig0-f179.google.com with SMTP id r2so13192905igi.6
        for <git@vger.kernel.org>; Tue, 30 Dec 2014 15:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=a5+3SlaJwhPfcEy3wujYV69TQRYXmF4XI3OGfiaf2ag=;
        b=ieBHYBYsgc4Avb6+O2Et0Vjzxd9it50vazZJmvqPAELoZfnKKV0gF5z2Xz1koxIlMQ
         c+3rxJEbsfxJfEUzTFEbrCSGdWd8Qri2pt6LdgfoUTpkWOQXV2lJO2ESiGhY4o6wl7aW
         Lm7l42bmRzONR4YSpp6r0Cw+bqJrG/u1W4jQ2farHnuwhN8E5Ol7HGUT/6D9DQCkfLjw
         9xdRCYvqNXma6ker/D2JzYjhgUb6TnbJ53QRNk92a7xT8G6jWKG1RrFG4m2j+84F+cU/
         7FhBKFVVAH4ngg1+9WVbuEgMwiccfnDioIEwDI90PPQFi/3dGG5ef0xNcnfADAXx/qzp
         6y0g==
X-Received: by 10.107.131.102 with SMTP id f99mr56677221iod.31.1419982239280;
        Tue, 30 Dec 2014 15:30:39 -0800 (PST)
Received: from flurp.local (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id g5sm19653387iod.25.2014.12.30.15.30.38
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 30 Dec 2014 15:30:38 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAGZ79kZcnu4ArwfEVNMh+mQjkYAvj=rJXP4jz2o6YF1t5=SQ6w@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261952>

On Mon, Dec 29, 2014 at 06:48:48PM -0800, Stefan Beller wrote:
> On Mon, Dec 29, 2014 at 6:47 PM, Stefan Beller <sbeller@google.com> wrote:
> > From: Eric Sunshine <sunshine@sunshineco.com>
> 
> As I just copied the whole text of Eric, I think
> it would be better if Eric is credited for this commit.
> 
> Eric,
> I already added your sign off to help Junio just pick it up.
> Please confirm that's ok.

You can have my sign-off with a rewritten commit message (below) plus a
minor grammatical fix to the existing text.

-- >8 --
From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] SubmittingPatches: explain rationale for using --notes with format-patch

While here, also change grammatically poor "three dash lines" to
"three-dash line".

Suggested-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/SubmittingPatches | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index e3c942e..8536bf3 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -176,8 +176,11 @@ message starts, you can put a "From: " line to name that person.
 
 You often want to add additional explanation about the patch,
 other than the commit message itself.  Place such "cover letter"
-material between the three dash lines and the diffstat. Git-notes
-can also be inserted using the `--notes` option.
+material between the three-dash line and the diffstat.  For
+patches requiring multiple iterations of review and discussion,
+an explanation of changes between each iteration can be kept in
+Git-notes and inserted automatically following the three-dash
+line via `git format-patch --notes`.
 
 Do not attach the patch as a MIME attachment, compressed or not.
 Do not let your e-mail client send quoted-printable.  Do not let
-- 
2.2.1.313.gcc831f2
