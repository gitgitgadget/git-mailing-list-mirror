From: "Govind Salinas" <govind@sophiasuchtig.com>
Subject: Re: Git Notes idea.
Date: Fri, 19 Dec 2008 11:42:42 -0600
Message-ID: <5d46db230812190942j2670b120ga7ec49798a5dd49d@mail.gmail.com>
References: <5d46db230812160015t55b4ff2fubbf1e2f826a97b98@mail.gmail.com>
	 <20081216085108.GA3031@coredump.intra.peff.net>
	 <5d46db230812161043m4a5873a8w4c323d634b639ba0@mail.gmail.com>
	 <alpine.DEB.1.00.0812170003540.14632@racer>
	 <5d46db230812161815s1c48af9dwc96a4701fb2a669b@mail.gmail.com>
	 <alpine.DEB.1.00.0812170420560.14632@racer>
	 <20081217101110.GC18265@coredump.intra.peff.net>
	 <alpine.DEB.1.00.0812171233270.28560@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 19 18:44:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDjOM-0007e8-3c
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 18:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751681AbYLSRmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 12:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751627AbYLSRmo
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 12:42:44 -0500
Received: from mail-gx0-f13.google.com ([209.85.217.13]:58145 "EHLO
	mail-gx0-f13.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbYLSRmn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 12:42:43 -0500
Received: by gxk6 with SMTP id 6so1035866gxk.13
        for <git@vger.kernel.org>; Fri, 19 Dec 2008 09:42:42 -0800 (PST)
Received: by 10.150.140.6 with SMTP id n6mr5943841ybd.188.1229708562405;
        Fri, 19 Dec 2008 09:42:42 -0800 (PST)
Received: by 10.151.135.7 with HTTP; Fri, 19 Dec 2008 09:42:42 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0812171233270.28560@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103572>

On Wed, Dec 17, 2008 at 5:38 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 17 Dec 2008, Jeff King wrote:

>> If he is planning on doing a separate pyrite implementation, then it
>> _hasn't_ been implemented yet. And I don't care there if he uses hash
>> tables or sorted lists or whatever. I think the most important thing is
>> getting down the design of the _data structure_, so that we can have a
>> compatible implementation inside git itself.
>
> Well, I don't care about pyrite.  As far as I am concerned, it might as
> well use an incompatible version.  I really don't care.

Well I do care.  It would not be a good thing for anyone to have 2 separate
systems for notes.  Let us say that someone who you work with uses pyrite
and you don't.  They will add notes which you can't see and vice versa.

Thanks,
Govind.
