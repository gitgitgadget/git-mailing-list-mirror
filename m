From: "Stephen Sinclair" <radarsat1@gmail.com>
Subject: Re: An alternate model for preparing partial commits
Date: Sat, 28 Jun 2008 15:13:18 -0400
Message-ID: <9b3e2dc20806281213o345ff9e7v77f0b151eeba4e6e@mail.gmail.com>
References: <g43jlg$54g$1@ger.gmane.org> <-8386235276716376372@unknownmsgid>
	 <9af502e50806271555j3cd06ecau122b11217f612217@mail.gmail.com>
	 <7viqvuo4hq.fsf@gitster.siamese.dyndns.org>
	 <9af502e50806271708p7979ae65k61b71be90efff2c4@mail.gmail.com>
	 <9b3e2dc20806280734i6ca17cc8i447c2e2db67e8051@mail.gmail.com>
	 <9af502e50806280930u788f81e2j77adf147a0e4d135@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Jun 28 21:14:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCfsP-00021b-SV
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 21:14:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752202AbYF1TNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 15:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbYF1TNU
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 15:13:20 -0400
Received: from rv-out-0506.google.com ([209.85.198.235]:36956 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751981AbYF1TNU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 15:13:20 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1068324rvb.1
        for <git@vger.kernel.org>; Sat, 28 Jun 2008 12:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=ccgMkZcKbFdZaLD3Jo+uO7KqUq4xqpORqolG7IKwVlM=;
        b=rHZ8UZo8AtDgjUOZPLXNveCoUPuRH6v5H75a1qBybmwT0pMXu5i8N/1+Ircs4zjA++
         9iWJsB7GVzmSknTnmYbcIDwcFtzB5pefpXDM8l+pPWkb70vc5l6wfhm+AYCFztDqWzf0
         EH2P2Dg+g7uVfbewVMR09gRxZ3Gp7+H3eHbO8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=LOXc2PXPt+nDSyOafO92gQS51ouygQgibWJ5QLOMYSH5m2PNVeBmzgDeYkHxmz6U5k
         d1erMfm8+ttrtLNT4SdhfEClmXzO+m/CC6o+vHERTmT5naLfwewHlkrd0y7E8Lm4ZS7t
         qENheP1wxbYG8FZyKVzfBhyZWlCeJ3tdJ53P0=
Received: by 10.140.165.21 with SMTP id n21mr1632946rve.97.1214680398721;
        Sat, 28 Jun 2008 12:13:18 -0700 (PDT)
Received: by 10.140.166.19 with HTTP; Sat, 28 Jun 2008 12:13:18 -0700 (PDT)
In-Reply-To: <9af502e50806280930u788f81e2j77adf147a0e4d135@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86737>

On Sat, Jun 28, 2008 at 12:00 PM, Robert Anderson <rwa000@gmail.com> wrote:
> On Sat, Jun 28, 2008 at 7:34 AM, Stephen Sinclair <radarsat1@gmail.com> wrote:
>> The answer is simple: you should not be making partial commits to a
>> repo that has been cloned.  You should instead be working somewhere
>> else and then pushing to it.  So this whole sentence is just a moot
>> point itself.
>
> Ah, now you've hit the crux.  Thank you for the "svn style" response
> here.  I "should not" because git has a deficiency.  Absolutely no
> other reason.

No, you said that a certain operation (testing partial commits) was
impossible.  I told you how I approach the problem with git and tried
to show that it was entirely possible.  That is all.


On Sat, Jun 28, 2008 at 12:30 PM, Robert Anderson <rwa000@gmail.com> wrote:
> Why should I have to pull, commit, hack, and push, when hack and
> commit is all I need to do the vast majority of the time?

But what you have described here, the difference between "commit/push"
and just "commit", is _exactly_ what differentiates distributed and
centralized SCM systems.

To go back to the basic problem that you suggested, that partial
commits can easily go untested, in the "hack and commit" model this is
impossible to work around.  In the "hack, commit, go back and fix,
commit, push" model, which git makes possible, it _is_ possible to do
the testing that you desire.


Steve
