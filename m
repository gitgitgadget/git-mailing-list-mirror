From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: Management of opendocument (openoffice.org) files in git
Date: Tue, 16 Sep 2008 21:28:30 +0200
Message-ID: <20080916192830.GA16455@cuci.nl>
References: <loom.20080915T222909-709@post.gmane.org> <48CF5B90.5050800@viscovery.net> <48CF630F.4090808@gmail.com> <32541b130809160904v7acc73cfm4856c33d40555e94@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sergio Callegari <sergio.callegari@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 21:29:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KfgF2-0002bL-IV
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 21:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754578AbYIPT2d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 15:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbYIPT2c
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 15:28:32 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:34166 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754657AbYIPT2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 15:28:32 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 951065465; Tue, 16 Sep 2008 21:28:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <32541b130809160904v7acc73cfm4856c33d40555e94@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96030>

Avery Pennarun wrote:
>On Tue, Sep 16, 2008 at 3:41 AM, Sergio Callegari
><sergio.callegari@gmail.com> wrote:
>> Johannes Sixt wrote:
>IIRC zip files keep their index at the end of the file, which means
>zipping in a pipeline is efficient (you can write all the blocks
>first, then drop the final index at the end) but unzipping that way is
>really hard.

Well, the index *is* at the end, yes, however, almost all (if not all) the
information in the index is present directly in front of the files as
well, so unzipping from stdin is possible without seeks (though the
standard unzip doesn't support that (yet) because it tries to verify
integrity and speed up lists using the index at the end).
-- 
Sincerely,
           Stephen R. van den Berg.

Human beings were created by water to transport it uphill.
