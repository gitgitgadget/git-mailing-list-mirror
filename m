From: Victor Bogado da Silva Lins <victor@bogado.net>
Subject: global hooks
Date: Wed, 19 Mar 2008 13:04:31 -0300
Message-ID: <1205942671.691.8.camel@omicron.ep.petrobras.com.br>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 19 23:34:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc6rQ-0007LP-Vq
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016AbYCSWcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964772AbYCSWck
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:32:40 -0400
Received: from hapkido.dreamhost.com ([66.33.216.122]:51515 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161637AbYCSWci (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:32:38 -0400
Received: from spunkymail-a6.g.dreamhost.com (sd-green-bigip-83.dreamhost.com [208.97.132.83])
	by hapkido.dreamhost.com (Postfix) with ESMTP id 4CDC817811F
	for <git@vger.kernel.org>; Wed, 19 Mar 2008 09:10:28 -0700 (PDT)
Received: from [127.0.0.1] (unknown [139.82.86.2])
	by spunkymail-a6.g.dreamhost.com (Postfix) with ESMTP id 75E80109F2F
	for <git@vger.kernel.org>; Wed, 19 Mar 2008 09:08:20 -0700 (PDT)
X-Mailer: Evolution 2.8.0 (2.8.0-40.el5) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77575>

Hi, I made a prepare-commit-msg hook today, it basically appends the
diff I am about to commit to the commented information that normally
appears. 

The problem is that if I want this hook in all projects I have, I have
to copy that file to every single project I have. This is an error prone
operation, not to mention a pain in the... .

SO my question is, is there a way to make that hook global to all
projects? If not, would it be a good idea to allow this?
