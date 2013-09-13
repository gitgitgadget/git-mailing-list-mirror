From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH V2 0/3] Extend dot repository documentation
Date: Fri, 13 Sep 2013 22:23:14 +0100
Message-ID: <1379107397-964-1-git-send-email-philipoakley@iee.org>
References: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 23:23:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKapw-0003am-6v
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 23:23:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754761Ab3IMVXL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 17:23:11 -0400
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:62497 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753354Ab3IMVXK (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 Sep 2013 17:23:10 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AnMHAMaBM1JOl3GZ/2dsb2JhbABbgweuBpN/gRwXdIImAQVWIxAISTkeBgGIGbk+j3EHhB4DqW6DJTs
X-IPAS-Result: AnMHAMaBM1JOl3GZ/2dsb2JhbABbgweuBpN/gRwXdIImAQVWIxAISTkeBgGIGbk+j3EHhB4DqW6DJTs
X-IronPort-AV: E=Sophos;i="4.90,900,1371078000"; 
   d="scan'208";a="441938733"
Received: from host-78-151-113-153.as13285.net (HELO localhost) ([78.151.113.153])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 13 Sep 2013 22:23:08 +0100
X-Mailer: git-send-email 1.8.1.msysgit.1
In-Reply-To: <1368964449-2724-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234771>

This is an update to my patch series on 19 May documenting the
dot repository notation.

The earlier threads start at:
$gmane/224870/ [0/2] Extend dot repository documentation
$gmane/224868/ [1/2] config doc: add dot-repository note
$gmane/224869/ [2/2] doc: command line interface (cli) dot-repository
dwimmery

The base documentation is now the URLs section (first patch) as suggested by Jonathan,
with a clarification in config(1) branch.<name>.remote, and finally a note in cli(7).

The patches can be squashed together if appropriate.

Philip
--

Philip Oakley (3):
  Doc URLs: relative paths imply the dot-respository
  config doc: update dot-repository notes
  doc: command line interface (cli) dot-repository dwimmery

 Documentation/config.txt | 6 ++++--
 Documentation/gitcli.txt | 4 ++++
 Documentation/urls.txt   | 7 +++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

-- 
1.8.1.msysgit.1
