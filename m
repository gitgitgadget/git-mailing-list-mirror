From: "Alan Hadsell" <ahadsell@gmail.com>
Subject: Re: [PATCH] mergetool: add support for ECMerge
Date: Tue, 9 Oct 2007 10:21:27 -0400
Message-ID: <2b3a6fcd0710090721p28891ec0r5f385ff6fd1465c4@mail.gmail.com>
References: <11918785613855-git-send-email-prohaska@zib.de>
	 <11918785611059-git-send-email-prohaska@zib.de>
	 <20071008214451.GB31713@thunk.org>
	 <1C50C046-3D61-4D55-8D38-B2D563C1FF2A@zib.de>
	 <Pine.LNX.4.64.0710091335580.4174@racer.site>
	 <2b3a6fcd0710090603l3c3578caq3bfa6a1b8ec583f@mail.gmail.com>
	 <236E44B5-361E-4CE3-8C3D-BDAD0569642E@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Theodore Tso" <tytso@mit.edu>
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Tue Oct 09 16:21:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfFxr-0004Nw-3O
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 16:21:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752552AbXJIOVa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 10:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752180AbXJIOVa
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 10:21:30 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:54993 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbXJIOV3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 10:21:29 -0400
Received: by wr-out-0506.google.com with SMTP id 36so821684wra
        for <git@vger.kernel.org>; Tue, 09 Oct 2007 07:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=tUtNZNSXI8+76SUTgh3FvYecBUzZlwXlJupAYXKsDnE=;
        b=K1iKqiyztjdcssQ8joPwDciVQST3OtrONb2Oag5YuyFjzTAGcKhXHk1oWN3yjucd/e0kwI5bQrrM6VBIVukokdzuqxHl6twyPLBYC6iO43iSTOLTbykVjOa8G6rzSqXaTqO+7suKWFcqZyRuMyaRQNyolNTAs8/5nq77rC6Wfwc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fm9KB463C0mOV8z/DO+ui6zlPgaR1+TUwLWeO5Vcg5cNbVOGsZwM0Hgljo9FWsGr7bdZY965wFofc4JFLArZm0SeYTZyW0Qmi2Ds0dEXHpHN6bBPns6VWTfQq6pMvmz74hZ2/lFCJkWrmaIUTps5OsRbRxI99uJp9mJQoOWXhM0=
Received: by 10.90.71.3 with SMTP id t3mr5644641aga.1191939687094;
        Tue, 09 Oct 2007 07:21:27 -0700 (PDT)
Received: by 10.90.101.15 with HTTP; Tue, 9 Oct 2007 07:21:27 -0700 (PDT)
In-Reply-To: <236E44B5-361E-4CE3-8C3D-BDAD0569642E@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60416>

Steffen Prohaska writes:

> WinMerge doesn't support 3-way merges. At least I cannot find any
> indication for 3-way in the manual [1] and the comparison at [2] also
> tells that WinMerge doesn't support 3-way.

>From their FAQ:

Does WinMerge support merging three files? Sometimes it is called
3-way merge, where one file is ancestor. This would be useful for
version control!

Unfortunately not. We acknowledge it would be good feature but have no
plans to implement it in near future. This can be somewhat worked
around by using two WinMerge instances. (One developer has begun
preliminary work on this feature, but it is not yet available, even in
experimental releases.)
