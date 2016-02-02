From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 00/15] config: make git_config_set die on failure
Date: Tue, 2 Feb 2016 10:52:48 -0800
Message-ID: <CAGZ79kb-tATWrCgw5PFRK=W43JLH-mN-VSac7b5Z39Hpe3qXxw@mail.gmail.com>
References: <1454413916-31984-1-git-send-email-ps@pks.im>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Tue Feb 02 19:53:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQg4P-00020v-4S
	for gcvg-git-2@plane.gmane.org; Tue, 02 Feb 2016 19:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757126AbcBBSwx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 13:52:53 -0500
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35073 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757090AbcBBSwt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 13:52:49 -0500
Received: by mail-ig0-f176.google.com with SMTP id t15so67859908igr.0
        for <git@vger.kernel.org>; Tue, 02 Feb 2016 10:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wmexqdsfvoG4FR5k/YQD0E6oPGE3na9gRITREBqA2F0=;
        b=XbRI6x1W9U6XnuyYD/w3oVHDFv6k3560kgQFSVcX9teEdyXHDWLdNE1TrIsut43brX
         AaRE3wTivWLCmELm36TN0OO9fYQpLf7RYAa/i2PuyfIc/fPcbE9Lc6+BvjeaUQ/bt0nv
         ySQG5y8Wek5+Qrj9XcX/LHJazoG/EuzPXGfFEIdWkKyZlwbcmgPI2q28NzsTcciFEFeh
         ckmKg/eG5ES/wpzrsuggssaggkxwJc38SR+loNswqIxL1npZGH6FKGch6kluGGcE/Ku8
         EoHoaPILhOhkla7P35L4UZ7KwhSmumfigDXv3JFTJGv7a125pimgw8d14RVvqhAgM5lk
         yijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=wmexqdsfvoG4FR5k/YQD0E6oPGE3na9gRITREBqA2F0=;
        b=SCJAIldh3KSG3tWXyruaB14/8bvHFzyajvphyXocyYNWQ4ZM2cJh+SySoq1rJ7eOay
         fKLpNetsK/ux0LHEvxGc5PbBj1C4hxp3mZ08IzyPHL7PGiigtr0yvz+bdmwrLDuVVTNn
         MNYfGUQkonWDBMAFdYRZW1VSB47MCSQ1dR3wdNfB9jYzKXHdr9FeOyovR0GeMdO58IBo
         Hr1vbKRXxYE9jdsJgRbU5ETT1KygGELC69DBVXM3o9+Y0zq5dfSOnyD6vfFB9T8leEtf
         6W+m7lSomaFIuwNNP6YUs6xSd3mmNvUeltEsK76ixPZw2WoZDxOMPNvDGlfbZN5E/TDo
         gcYQ==
X-Gm-Message-State: AG10YOSLY429t4trEjPUYCSLkDZesGR4D80pTo7XQPFqbQGfzNt83QFNboK+L9Ts/f1c7tzOh23XgGHGoRQmc8vW
X-Received: by 10.50.28.105 with SMTP id a9mr19732875igh.94.1454439168358;
 Tue, 02 Feb 2016 10:52:48 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 2 Feb 2016 10:52:48 -0800 (PST)
In-Reply-To: <1454413916-31984-1-git-send-email-ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285297>

On Tue, Feb 2, 2016 at 3:51 AM, Patrick Steinhardt <ps@pks.im> wrote:
>   submodule: die on config error when linking modules
>   submodule--helper: die on config error when cloning module

The code in the submodule related patches looks fine to me.
