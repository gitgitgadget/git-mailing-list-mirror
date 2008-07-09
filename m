From: Dave Quigley <dpquigl@tycho.nsa.gov>
Subject: Merging a foreign tree into a bare repository.
Date: Tue, 08 Jul 2008 20:14:28 -0400
Message-ID: <1215562468.4199.26.camel@moss-terrapins.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 09 02:30:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGNa1-000820-T8
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 02:30:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752095AbYGIA3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 20:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbYGIA3s
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 20:29:48 -0400
Received: from mummy.ncsc.mil ([144.51.88.129]:58382 "EHLO mummy.ncsc.mil"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbYGIA3r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 20:29:47 -0400
Received: from facesaver.epoch.ncsc.mil (jazzhorn.ncsc.mil [144.51.5.9])
	by mummy.ncsc.mil (8.12.10/8.12.10) with ESMTP id m690Tjfn001563
	for <git@vger.kernel.org>; Wed, 9 Jul 2008 00:29:46 GMT
Received: from [144.51.25.2] (moss-terrapins [144.51.25.2])
	by facesaver.epoch.ncsc.mil (8.13.1/8.13.1) with ESMTP id m690TjFJ019553
	for <git@vger.kernel.org>; Tue, 8 Jul 2008 20:29:45 -0400
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8) 
X-Spam-Status: No, score=-103.8 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00,
	USER_IN_WHITELIST autolearn=ham version=3.1.8
X-Spam-Checker-Version: SpamAssassin 3.1.8 (2007-02-13) on
	facesaver.epoch.ncsc.mil
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87819>

Hello,
   I created a bare copy of Linus' 2.6 kernel tree which I am using for
some public development. I have a branch in this tree called patchset
which has a series of commits based on a patch set that I have. Now I
want to update this copy from the kernel.org git repository and rebase
the patches in the patchset branch. I typed git-fetch <URL to Linus'
tree> and it successfully fetched the remote objects. I tried to then
merge them but you need a working directory to merge the changes which
makes sense. Normally if I had a working directory I would use
git-rebase to rebase my patches on a working tree but since this is a
bare repository I can't do that. How would one go about doing this with
a bare repository? Is there a better way of doing this that I am not
aware of? Is my work flow completely off?

Dave
