From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: submodule update --init --recursive doesn`t work git 1.7.10
Date: Tue, 12 Jun 2012 18:49:33 +0200
Message-ID: <20120612164933.GA15093@book.hvoigt.net>
References: <CAMgq-fJN=-XnHOZyAUbQ4uiQ61Ryzn-4d69QBtUJeXAxNvSBiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Piotr Pientka <p.pientka@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 18:49:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeUHk-0004hN-QM
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 18:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab2FLQth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 12:49:37 -0400
Received: from smtprelay02.ispgateway.de ([80.67.31.40]:46402 "EHLO
	smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415Ab2FLQtg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 12:49:36 -0400
Received: from [77.20.33.80] (helo=localhost)
	by smtprelay02.ispgateway.de with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.68)
	(envelope-from <hvoigt@hvoigt.net>)
	id 1SeUHd-0005zi-U6; Tue, 12 Jun 2012 18:49:34 +0200
Content-Disposition: inline
In-Reply-To: <CAMgq-fJN=-XnHOZyAUbQ4uiQ61Ryzn-4d69QBtUJeXAxNvSBiw@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Df-Sender: aHZvaWd0QGh2b2lndC5uZXQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199811>

Hi,

On Tue, Jun 12, 2012 at 10:07:02AM +0200, Piotr Pientka wrote:
> When I have nested submodules, after Add new nested submodule and make
> "submodule update --init --recursive", I have failed while cloning
> nested modules.
> It looks like is a problem with path to .git
> 
> But when I add new submodule and make "submodule update --init" on
> each nested module, it works , but I must do it manually
> 
> It only happends on git 1.7.10. On git 1.7.4 it works fine.

This description is missing some information. Might this be the same
issue with relative superproject origin urls these patches

http://thread.gmane.org/gmane.comp.version-control.git/199314


are trying to address?

Could you provide a script that illustrates what you are seeing?

Cheers Heiko
