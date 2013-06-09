From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Mon, 10 Jun 2013 00:14:36 +0530
Message-ID: <CALkWK0nsJ5ds5v7auoqN7_vXhOoasJ3y99njZt5btPVqRCF2zA@mail.gmail.com>
References: <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
 <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
 <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
 <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
 <CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
 <CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
 <20130609043444.GA561@sigill.intra.peff.net> <CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
 <20130609175554.GA810@sigill.intra.peff.net> <CALkWK0n0kkNZo_Xt1oT5GL-TxZP0faDExxyH3vU-+hy4uEUEtQ@mail.gmail.com>
 <20130609182246.GE810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 20:45:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlkcG-0005y7-AG
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 20:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751630Ab3FISpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 14:45:18 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:57361 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab3FISpR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 14:45:17 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar20so12091918iec.21
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 11:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=FEZcqv2Zd1eGiJQGXjxI7dSqlxieDEuWs4Z1PDJPJhs=;
        b=qdZBcmXZxcxxLwZA4HvCezmOp7B5vsvhuALK1N94T2yr01uo+J3FgUJkBCf6wePgig
         nnNlNFyJwGQrpljV2h8DERm2ei23Yx6+tZZL/Yirg6XWaxFlK4IhCBBFP2y4ahCq6ZXc
         1PSUUjEFYu0u1EC12a7FT2LQ8bxda82cjWAkEYFVQ/dZz57FC5NeJxRK448SrYyYBE68
         YFNFyzue8F+fsEGnmUXzRihGJ9r+cAkVJvX8j8pCFfoZUM+jQDvuxs8Yc4XLVD7YOlX6
         1SHbT2e6ENE2iykM6uD0Ln+Ww7ffgEVqj4IlSHHjI6BmygVTgH4HJKFucurqfTew7t/I
         JB2Q==
X-Received: by 10.43.53.211 with SMTP id vr19mr2730327icb.33.1370803516897;
 Sun, 09 Jun 2013 11:45:16 -0700 (PDT)
Received: by 10.64.129.97 with HTTP; Sun, 9 Jun 2013 11:44:36 -0700 (PDT)
In-Reply-To: <20130609182246.GE810@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227092>

Jeff King wrote:
> Sorry, I don't have patches. It is a hard problem for which I do not
> have the solution, which is kind of my point.

So, what is the problem?  We are moving towards what we think is the
way forward.  Nobody said that it is the theoretical best, but it's
_much_ better than doing nothing, no?

> For the record, I am not _against_ any code organization that might be
> useful for lib-ification later. I just do not see it as an interesting
> step to be discussing if you want to know whether such a lib-ification
> effort is feasible.

Then whom are we to ask about this feasibility?  All the core
contributors (including Junio) are in the CC.  Nobody has said
anything.  So, are you proposing that we sit and ponder over our
theoretically-indeterminate-feasibility problem?  There is no magic
bullet, Jeff.  We write code, and we fix bugs as and when they crop
up; there's really not much else anyone can do.  Help by writing code,
or reviewing someone else's code.
