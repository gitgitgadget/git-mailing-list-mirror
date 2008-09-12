From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-gui: I18n fix sentence parts into full sentences
	for translation again.
Date: Fri, 12 Sep 2008 08:39:34 -0700
Message-ID: <20080912153934.GG22960@spearce.org>
References: <200809121117.39407.stimming@tuhh.de> <bb6f213e0809120323l3c18cd32hfde9ef6756593061@mail.gmail.com> <200809121232.14364.stimming@tuhh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alexander Gavrilov <angavrilov@gmail.com>, git@vger.kernel.org
To: Christian Stimming <stimming@tuhh.de>
X-From: git-owner@vger.kernel.org Fri Sep 12 17:40:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeAlH-0004yF-VT
	for gcvg-git-2@gmane.org; Fri, 12 Sep 2008 17:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753601AbYILPjg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2008 11:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753408AbYILPjg
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Sep 2008 11:39:36 -0400
Received: from george.spearce.org ([209.20.77.23]:42325 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbYILPjf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2008 11:39:35 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8653F3835C; Fri, 12 Sep 2008 15:39:34 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200809121232.14364.stimming@tuhh.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95738>

Christian Stimming <stimming@tuhh.de> wrote:
> Am Freitag, 12. September 2008 12:23 schrieb Alexander Gavrilov:
> > On Fri, Sep 12, 2008 at 1:17 PM, Christian Stimming <stimming@tuhh.de> 
> wrote:
> > >-       set op_question [mc "Force resolution to %s?
> > >-Note that the diff shows only conflicting changes.
> > >+    set op_question [strcat $targetquestion "\n" \
> > >+[mc "Note that the diff shows only conflicting changes.
> >
> > ...
> >
> > > -               $target [short_path $current_diff_path]]
> > > +               $targetquestion [short_path $current_diff_path]]]
> >
> > You should remove this $target completely -- there is no %s to match it
> > anymore.
> 
> Oh - right. Thanks for pointing this out. Please modify the patch accordingly.

Fixed and applied.  Thanks, both.

-- 
Shawn.
