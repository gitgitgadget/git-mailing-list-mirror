From: Charles Bailey <charles@hashpling.org>
Subject: Re: Question about your git habits
Date: Sat, 23 Feb 2008 13:17:49 +0000
Message-ID: <20080223131749.GA5811@hashpling.org>
References: <200802221837.37680.chase.venters@clientec.com> <Pine.LNX.4.64.0802230221140.21077@fbirervta.pbzchgretzou.qr> <20080223014445.GK27894@ZenIV.linux.org.uk> <7vfxvk4f07.fsf@gitster.siamese.dyndns.org> <20080223020913.GL27894@ZenIV.linux.org.uk> <998d0e4a0802221823h3ba53097gf64fcc2ea826302b@mail.gmail.com> <998d0e4a0802221847m431aa136xa217333b0517b962@mail.gmail.com> <20080223113952.GA4936@hashpling.org> <998d0e4a0802230508w12f236baiaf2d9ab5f364670a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: LKML <linux-kernel@vger.kernel.org>, git@vger.kernel.org
To: "J.C. Pizarro" <jcpiza@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 23 14:18:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSuH9-0000J2-QX
	for gcvg-git-2@gmane.org; Sat, 23 Feb 2008 14:18:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753758AbYBWNSA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Feb 2008 08:18:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753777AbYBWNSA
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Feb 2008 08:18:00 -0500
Received: from pih-relay06.plus.net ([212.159.14.133]:46873 "EHLO
	pih-relay06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753624AbYBWNR7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Feb 2008 08:17:59 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1JSuGL-0006x8-Ut; Sat, 23 Feb 2008 13:17:58 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1NDHou8006699;
	Sat, 23 Feb 2008 13:17:50 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1NDHnd4006698;
	Sat, 23 Feb 2008 13:17:49 GMT
Content-Disposition: inline
In-Reply-To: <998d0e4a0802230508w12f236baiaf2d9ab5f364670a@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 243ca5111fa1e5deae0cdbdc9909802a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74822>

On Sat, Feb 23, 2008 at 02:08:35PM +0100, J.C. Pizarro wrote:
> 
> But if the repos are aggressively repacked then the bit to bit differences
> are not ~2 MiB.

It shouldn't matter how aggressively the repositories are packed or what
the binary differences are between the pack files are. git clone
should (with the --reference option) generate a new pack for you with
only the missing objects. If these objects are ~52 MiB then a lot has
been committed to the repository, but you're not going to be able to
get around a big download any other way.
