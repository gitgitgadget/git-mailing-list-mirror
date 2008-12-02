From: "Jason Foreman" <jason@threeve.org>
Subject: Re: git-p4, SyntaxError: invalid syntax
Date: Tue, 2 Dec 2008 13:45:04 -0600
Message-ID: <f9aa767e0812021145v1ecc9c56k6ad06ac7678e3d0d@mail.gmail.com>
References: <186027.87419.qm@web37901.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "git list" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 02 20:46:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7bCq-0005aY-6h
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 20:46:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551AbYLBTpI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 14:45:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754408AbYLBTpH
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 14:45:07 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:23558 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384AbYLBTpG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 14:45:06 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1670123nfc.21
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 11:45:04 -0800 (PST)
Received: by 10.210.87.14 with SMTP id k14mr14448027ebb.159.1228247104072;
        Tue, 02 Dec 2008 11:45:04 -0800 (PST)
Received: by 10.210.118.13 with HTTP; Tue, 2 Dec 2008 11:45:04 -0800 (PST)
In-Reply-To: <186027.87419.qm@web37901.mail.mud.yahoo.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102170>

On Tue, Dec 2, 2008 at 1:08 PM, Gary Yang <garyyang6@yahoo.com> wrote:
>
> /home/gyang/bin/git-p4:161: Warning: 'yield' will become a reserved keyword in the future
>  File "/user/svdc/pluo/bin/git-p4", line 161
>    yield pattern
>                ^
> SyntaxError: invalid syntax
>

This seems to indicate that your python doesn't support the "yield"
keyword (used in generators).

Are you using Python 2.2?  If so, that is a very old Python and I'd
recommend upgrading.  But even with 2.2 you can fix this by adding the
following import line:

from __future__ import generators

I'm not familiar with the git-p4 file specifically but the above
should hopefully fix your problem.


Cheers,

Jason
