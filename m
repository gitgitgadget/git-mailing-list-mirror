From: "David Symonds" <dsymonds@gmail.com>
Subject: Re: Unable to clone an ssh repository (with ugly installation-specific workaround)
Date: Mon, 11 Feb 2008 23:04:35 -0800
Message-ID: <ee77f5c20802112304j2a73c480h8add21b189d794d5@mail.gmail.com>
References: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Elijah Newren" <newren@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 08:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOpCj-0001pn-7A
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 08:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755850AbYBLHEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 02:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754942AbYBLHEi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 02:04:38 -0500
Received: from wa-out-1112.google.com ([209.85.146.178]:20408 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754746AbYBLHEh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 02:04:37 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2611376wah.23
        for <git@vger.kernel.org>; Mon, 11 Feb 2008 23:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ee8ZU/u+JwFmM/4HA3ydfpQgr98AbLau1FG2hfqjJ4E=;
        b=bhJmPgr09yHk1KuE2IhN6pe1ycLHIlYpARpCcl4TYgJn0FJYzeKtyuSX/yg17ajil5DHRjcYfiLM2/YaJsAv34phxPyFWLj6aL1TmUQa8VgVI72HHVvNxxs0cpBsTQGUJ+UH8T9AP0Xl5bpPFLiaeR9YilMNxMTOzSNo7C4LkbU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PHXKGRs30fbNPwQYTAgHbrL5JMarhY5N/TddhYc62PTgL3BUO45poQz2XmKVqUcBSOS416kZXs3YLuFZhmSwjJFwsL82aw615Z9MJgbfHpRp2+RgqYf2mbeiLrYGQLGqsm3pw3gPGkaHBUFiadbuoWAELzdvH2JK6w4iqAFeEhU=
Received: by 10.140.208.14 with SMTP id f14mr669718rvg.204.1202799875608;
        Mon, 11 Feb 2008 23:04:35 -0800 (PST)
Received: by 10.140.135.17 with HTTP; Mon, 11 Feb 2008 23:04:35 -0800 (PST)
In-Reply-To: <51419b2c0802111822k4600e06bp4167a09b30bf947a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73629>

On Feb 11, 2008 6:22 PM, Elijah Newren <newren@gmail.com> wrote:
> Hi,
>
> I'm pretty sure this worked before, but with git-1.5.4, when trying to
> clone a repository via ssh from a machine that does not have git
> installed in a standard system path, I get the following:

Please post patches inline, not attached.

The problem you've encountered is to do with the PATH setup on the
remote end. See a previous thread
(http://thread.gmane.org/gmane.comp.version-control.git/72673/focus=72805)
for some solutions.


Dave.
