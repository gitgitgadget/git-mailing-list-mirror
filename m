From: Angelo Borsotti <angelo.borsotti@gmail.com>
Subject: Re: erratic behavior commit --allow-empty
Date: Wed, 3 Oct 2012 15:08:21 +0200
Message-ID: <CAB9Jk9Au32hGf-UB2PRa46qaA6GtpJ3jWL=SWWXns=Jc6O97KQ@mail.gmail.com>
References: <CAB9Jk9BynCunFHRFhGKoyDA-qof1iu6w952sAgSs2_JWb8+U3A@mail.gmail.com>
	<506AA51E.9010209@viscovery.net>
	<7vzk449449.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9CSW0ObJtgsfSwjf+k438=V8i7dP0p+YUehqdh2Z0k6tA@mail.gmail.com>
	<7vhaqc7in6.fsf@alter.siamese.dyndns.org>
	<CAB9Jk9D-eJ8goYx7LWqGcWcLgRDS8+qLZVUsvvJ+QOtryP9-zg@mail.gmail.com>
	<90464C79DA97415C9D66846A77ECAA4A@PhilipOakley>
	<CAB9Jk9ARWnE-cWVjqMUFiua21QjqGEX3VhYjKQMBSotVYXXK1Q@mail.gmail.com>
	<vpq626s6kwu.fsf@grenoble-inp.fr>
	<CAB9Jk9DFb2s4s00yCNUytxFdrOQKPEKZGsXpKzwZDo5WAOdXaQ@mail.gmail.com>
	<1349267146-ner-5314@calvin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Philip Oakley <philipoakley@iee.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git <git@vger.kernel.org>
To: Tomas Carnecky <tomas.carnecky@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 03 15:09:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJOgo-0006qc-72
	for gcvg-git-2@plane.gmane.org; Wed, 03 Oct 2012 15:08:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706Ab2JCNI0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 09:08:26 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:53115 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab2JCNIZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 09:08:25 -0400
Received: by vcbfo13 with SMTP id fo13so8209717vcb.19
        for <git@vger.kernel.org>; Wed, 03 Oct 2012 06:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KRyFDuVjvzdqwGNt8RqFCU2AeSH7nN2zZASkmldS6As=;
        b=I67W376R7C66uYd2OWlcNk/NNMjZyEGkYV4qgCacCVYFOSpOypqnWeBTgcRCzMJolZ
         tfRRxdKdjvmop9r5dYKLWJQjgO12M/Aoa8qJrpIXUqv2eqtMIu7TjpDf+Z/SMcNcLmYR
         E3XLwfV1iPN0slRdwE2dsPtX5SYkcexvTBfE/go88z9idbqwUvbjIZ9cMPrKeZVA19/O
         PyJH3GKNOxyTajYTNi+H6mt/aS126zHSuDlbvLsDcDLsXd4NdA1keCcu/vQhvgsjbpin
         Vlw0qsC8kDI/F8H8tJGNZ3a1iI1RxZRFluQgra8PQF5P7phpIwh4D8ci61/q1Bt99GUO
         W91Q==
Received: by 10.221.13.202 with SMTP id pn10mr1062705vcb.57.1349269701192;
 Wed, 03 Oct 2012 06:08:21 -0700 (PDT)
Received: by 10.58.68.40 with HTTP; Wed, 3 Oct 2012 06:08:21 -0700 (PDT)
In-Reply-To: <1349267146-ner-5314@calvin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206890>

Hi Thomas,

> The documentation only states that it will skip the 'same tree as parent'
> check, not that it will *always* create a new commit.

Ok, understood: you believe that the documentation is clear, and I
that it is somehow not.
I would prefer to have it more plain.

But that is not all the story. The behavior of the command remains
time-dependent,
so that a user cannot reliably predict its result. I think that this
is an ill-specified option.
I would not insist in removing it (although that would be the correct
solution), but at
least to warn the user about this possibly unexpected behavior.

-Angelo
