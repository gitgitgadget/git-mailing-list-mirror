Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16119C433DF
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 16:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91EE20720
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 16:40:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbgGBQkt convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 2 Jul 2020 12:40:49 -0400
Received: from elephants.elehost.com ([216.66.27.132]:11937 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgGBQkt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 12:40:49 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [173.32.57.223])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 062Geimi036694
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 2 Jul 2020 12:40:44 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Jason Pyeron'" <jpyeron@pdinc.us>, <git@vger.kernel.org>
Cc:     "'Matthew Horowitz'" <mhorowitz@pdinc.us>,
        "'Jakub Trzebiatowski'" <cubuspl42.1@gmail.com>
References: <CAAF2pWYNbZF5fqZVuakTmAguK7End3nFbRgfT=mRXFfmgD9LNA@mail.gmail.com> <0e9801d6508d$c1f55560$45e00020$@pdinc.us>
In-Reply-To: <0e9801d6508d$c1f55560$45e00020$@pdinc.us>
Subject: RE: Is git compliant with GDPR?
Date:   Thu, 2 Jul 2020 12:40:37 -0400
Message-ID: <03df01d6508f$873cc320$95b64960$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQI3a36ohrugQlw4W93V7edqWZTq6QHTAPwuqCOvOXA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On July 2, 2020 12:28 PM, Jason Pyeron wrote:
> Subject: RE: Is git compliant with GDPR?
> > -----Original Message-----
> > From: Jakub Trzebiatowski
> > Sent: Thursday, July 2, 2020 11:58 AM
> >
> First: I am not a lawyer, and even if I were, I (nor anyone else on this list)
> would not be your lawyer - get a lawyer.
> 
> Second: This thread is likely borderline off topic because for Git and GPDR to
> meet, it would be in the context of SaaS or your internal organization. There
> is almost nothing pure Git about these issues, see below. Discussion for the
> sake of it follows.
> 
> >
> > I've been using git for years, but I've never before taken part in the
> > discussion on the mailing list. I have a simple question, which
> > probably isn't easy to answer.
> >
> > Is git compliant with GDPR, the EU data protection law?
> >
> > Before I'm able to commit with git, I'm asked for my first and last
> > name. That is personal data.
> >
> > GDPR, Article 4, point (1):
> > ‘personal data’ means any information relating to an identified or
> > identifiable natural person (‘data subject’); [...]
> >
> > That data is handled by the git utility. It's sent to other parties
> > operating remote git servers (as a result of my commands, but as far
> > as I know that's not relevant). It sounds like it's being processed.
> 
> Git is like a hard drive or database in your organization. It does not do
> anything else than store the information.
> 
> Exception 1: IF you configure it to do so.
> 
> Exception 2: You are using a SaaS provider (e.g. github.com, gitlab.com, etc.)
> 
> Note: this is no different than any other SCM (e.g. CVS, Subversion, file
> shares, etc.).
> 
> >
> > GDPR, Article 4, point (2):
> > ‘processing’ means any operation or set of operations which is
> > performed on personal data or on sets of personal data, whether or not
> > by automated means, such as collection, recording, organisation,
> > structuring, storage, adaptation or alteration, retrieval,
> > consultation, use, disclosure by transmission, dissemination or
> > otherwise making available, alignment or combination, restriction,
> > erasure or destruction;
> >
> > This data is processed with a compatible computer owned by the end
> > user for the purpose of identification of git commits. It's sent to
> > other parties only when specific commands are given. All this was
> > defined by git authors/contributors (from all around the world).
> >
> 
> Again, like any database, you can query it for its contents. What you put in it
> is what it has. If you put personal data in, then it is there.
> 
> Where can data reside in Git?
> 
> 1. The blobs - e.g. your source code
> 
> 2. The commit messages.
> 
> #2 is your most likely candidate of GDPR related activities.
> 
> Do you use the developers names and email addresses in the message?
> Almost certainly.
> 
> Note: this is no different than any other SCM (e.g. CVS, Subversion, file
> shares, etc.).
> 
> > GDPR, Article 4, point (7):
> > ‘controller’ means the natural or legal person, public authority,
> > agency or other body which, alone or jointly with others, determines
> > the purposes and means of the processing of personal data; [...]
> >
> > Git authors can be considered joint controllers.
> >
> 
> The Git distributed model means that COPIES of all of the data are on each
> Git server and developer environment. You (and I mean your organization)
> must address this in your IT plans.
> 
> Note: this is no different than many other SCMs although some others SCM
> technologies only have the most recent version locally..
> 
> > If we'd assume the above interpretations, there would be many, many
> > consequences.
> >
> > I'm not a lawyer, and I have no idea if this interpretation is
> > reasonable. I don't even know if I'd like it to be. But here are some
> > facts: GDPR does focus on protecting the end user. Possibly, it's the
> > most strict data protection law in the world. It doesn't care how
> > difficult it is to adjust the organisation for compliance and it
> > doesn't care where the controller is located, as long as it processes
> > personal data of EU citizens (if I understand it correctly).
> >
> > Are there any lawyers in the git community? Could The Linux Foundation
> > help with legal support? It's a very non-trivial issue. It's non
> > obvious how local software relates to GDPR, and it's even more
> > difficult with Free/Open Source software with many, many authors. But
> > if the aforementioned interpretation was assumed, the git authors
> > could be held responsible for non-compliance.
> 
> 
> I have copied our Policy SME, maybe he will have opinions.

I am not speaking for the Git Foundation here, nor am I a lawyer; However, to use some practices from some of my customers who have this concern, the team members are directed to use tokenized names and email addresses that can be resolved by their security teams during an audit. Obviously the team members recognize the tokens so they know who is making what change. This means that externally, any names/emails that might get pushed upstream are non-identifying.

The problem with this approach is that it is not global. As a result, if you want to contribute to a public project you have to self-identify, which may imply consent under GDPR. This is for the protection of the project itself as a project cannot take code from anonymous sources. If you are unwilling to share that information, do not contribute to a project.

Randall

-- Brief whoami:
 NonStop developer since approximately 211288444200000000
 UNIX developer since approximately 421664400
-- In my real life, I talk too much.




