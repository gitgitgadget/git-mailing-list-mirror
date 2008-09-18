From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: Help breaking up a large merge.
Date: Thu, 18 Sep 2008 17:55:34 +0200
Message-ID: <adf1fd3d0809180855l42af4fb6l67275daef0d2a529@mail.gmail.com>
References: <20080918152154.GA27019@linode.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "David Brown" <git@davidb.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 17:56:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgLs6-000328-Pw
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 17:56:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbYIRPzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 11:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754024AbYIRPzi
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 11:55:38 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:30537 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753646AbYIRPzi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 11:55:38 -0400
Received: by nf-out-0910.google.com with SMTP id d3so2044058nfc.21
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 08:55:36 -0700 (PDT)
Received: by 10.103.249.7 with SMTP id b7mr3063817mus.2.1221753334995;
        Thu, 18 Sep 2008 08:55:34 -0700 (PDT)
Received: by 10.102.247.10 with HTTP; Thu, 18 Sep 2008 08:55:34 -0700 (PDT)
In-Reply-To: <20080918152154.GA27019@linode.davidb.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96205>

On Thu, Sep 18, 2008 at 5:21 PM, David Brown <git@davidb.org> wrote:
> Say we have a tree that we've been working on for a few months.  An
> outside vendor has also been working on the same tree during this
> time, and we need to merge with their work.
>
> The difficulty I'm having is that there are a lot of conflicts
> resulting from the merge (expected), and it would be nice to somehow
> be able to work on a smaller set of these conflicts at a time.

If the two (or at least one) branches have sufficient isolated commits
you can recreate the merges that could have happened, as is explained
(for monotone) in:

http://www.venge.net/mtn-wiki/ZipperMerge

Another option is to rebase one branch onto the other.

Even another option is to merge the two branches but use the rebased
tree to resolve the conflicts.

They are not for parallel merge resolution, but at least you can do
them incrementally.

HTH,
Santi
