From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Suggestion: make git checkout safer
Date: Wed, 3 Jun 2015 14:18:32 -0400
Message-ID: <004901d09e29$b38c2ba0$1aa482e0$@nexbridge.com>
References: <loom.20150603T104534-909@post.gmane.org>	<20150603090654.GD32000@peff.net>	<loom.20150603T110826-777@post.gmane.org>	<20150603093514.GF32000@peff.net>	<loom.20150603T114527-151@post.gmane.org>	<xmqqh9qoy9sx.fsf@gitster.dls.corp.google.com>	<004801d09e25$a339b0f0$e9ad12d0$@nexbridge.com> <xmqq4mmoy84y.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Ed Avis'" <eda@waniasset.com>, <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 20:18:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0DFR-0006Zn-Pc
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 20:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933484AbbFCSSi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 14:18:38 -0400
Received: from elephants.elehost.com ([216.66.27.132]:24546 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753381AbbFCSSg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 14:18:36 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t53IIX0j071300
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jun 2015 14:18:34 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <xmqq4mmoy84y.fsf@gitster.dls.corp.google.com>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQFyrraQjGmtUr2vpXILQHIThAtgLQIf/ulTAYu9CKgCESeLnQKam63aApAPjtgB9hB1fAF3zP6KneRJCvA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270719>

On June 3, 2015 2:11 PM Junio C Hamano wrote:
> "Randall S. Becker" <rsbecker@nexbridge.com> writes:
> > On June 3, 2015 1:35 PM Junio C Hamano wrote:
> >> Is that really true?  It all depends on why you came to a situation
> >> to have "missing files" in the first place, I would think, but "git
> >> checkout $path" is "I messed up the version in the working tree at
> >> $path, and want to restore them".  One particular kind of "I messed
> >> up" may be "I deleted by mistake"
> >> (hence making them "missing"), but is it so common to delete things
> >> by mistake, as opposed to editing, making a mess and realizing that
> >> the work so far was not improving things and wanting to restart from
> >> scratch?
> >
> > When working in an IDE like ECLIPSE or MonoDevelop, accidentally
> > hitting the DEL button or a drag-drop move is a fairly common trigger
> > for the "Wait-No-Stop-Oh-Drats" process which includes running git
> > checkout to recover.
> 
> That is an interesting tangent.  If you are lucky then the deleted file
may be
> unedited one, but I presume that you are not always lucky.  So perhaps
"git
> checkout" is not a solution to that particular IDE issue in the first
place?

Agreed. That's why I like knowing what's in my sausages and commit often.
Only lost a minor change once from this. I wonder what else is afoot. Ed,
can you expand on the issue?
