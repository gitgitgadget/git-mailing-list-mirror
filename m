From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Bugs in Gitosis
Date: Fri, 29 Oct 2010 05:32:14 +0530
Message-ID: <AANLkTik+CcuAtB=t5GgP9C-WrJRZt-LDNs3wUChhKTuz@mail.gmail.com>
References: <26E9B811E137AB4B95200FD4C950886BA9665D70@orsmsx507.amr.corp.intel.com>
	<vpq8w1if0yy.fsf@bauges.imag.fr>
	<26E9B811E137AB4B95200FD4C950886BA9665E50@orsmsx507.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: "Olsen, Alan R" <alan.r.olsen@intel.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 02:02:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBcQH-0002Jo-ED
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 02:02:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933340Ab0J2ACR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 20:02:17 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:38832 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933300Ab0J2ACP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Oct 2010 20:02:15 -0400
Received: by ywk9 with SMTP id 9so1688445ywk.19
        for <git@vger.kernel.org>; Thu, 28 Oct 2010 17:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=MbiRokVNWe4AHkOVrAUyPVI7DSzN4jUZ4T081Pbz/aI=;
        b=WQMGErkwfqw2h9m0dkyE7MlG54beE7iLVqoQ6nqBwcm8SQQ1ZG5bvAd4Qk6f734YBA
         7G75BOXqTFQMNwKkFZ8VSIWuZaViEG67l4rSM7zwWwnu6qJrV+gCPlFV3A7p838/0dcB
         U0g8rhzPpgqqXEpT0vN7JdZQouZHJgsHKe3uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=jIQCPUMrf+FsnwsRQSedidZtXzB89JxHq3fJWe0DyamMXmiMt2zhNJfJtdkGyfBjtb
         SEuRxcCA94rDG8mg/FvzlM0W2GT7jkm2LEtuJ+QaI019DDgnQ/srGPkH9mfhaSp5hlKj
         pNINbvZxVvrHQuvgKbTATqRqDWfu5xmrF7YoA=
Received: by 10.91.11.5 with SMTP id o5mr3514657agi.8.1288310534714; Thu, 28
 Oct 2010 17:02:14 -0700 (PDT)
Received: by 10.90.70.7 with HTTP; Thu, 28 Oct 2010 17:02:14 -0700 (PDT)
In-Reply-To: <26E9B811E137AB4B95200FD4C950886BA9665E50@orsmsx507.amr.corp.intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160254>

On Fri, Oct 29, 2010 at 3:52 AM, Olsen, Alan R <alan.r.olsen@intel.com> wrote:

> Does gitolite play well with Gerrit? I note in the docs that it does not react well to files under its control being messed with.

For the real reason I added that into the docs, see
http://github.com/sitaramc/gitolite/commit/10289c6d6494e7aa4204dfe29afec7535c1aa1a2

If <any other software> wants to add *other* files into repos that
gitolite does not need, that is perfectly fine.  Gitolite does not
expect to be "sole control", but just "don't mess with my stuff and
we'll get along fine".

However, I wasn't aware that it is even *possible* to run gerrit and
gitolite together.  Gerrit has its own customised ssh daemon, its own
customised "git", and so on.

I also fail to understand why you need gitolite if you're using
gerrit.  I believe gerrit can do all the access control that gitolite
can do.  See http://github.com/sitaramc/gitolite/blob/pu/contrib/gerrit.mkd
for a comparision

regards

sitaram
