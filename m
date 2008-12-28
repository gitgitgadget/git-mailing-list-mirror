From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Fix export check in git_get_projects_list
Date: Sat, 27 Dec 2008 22:54:36 -0800
Message-ID: <7vk59kaixf.fsf@gitster.siamese.dyndns.org>
References: <a899d7ef0812270139u7dd28ee1q45a8c05f7c95db2f@mail.gmail.com>
 <200812280312.02615.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Devin Doucette" <devin@doucette.cc>, git@vger.kernel.org,
	"Petr Baudis" <petr.baudis@novartis.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 28 07:56:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGpZF-00015r-TR
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 07:56:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbYL1Gyp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 01:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752118AbYL1Gyp
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 01:54:45 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbYL1Gyo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 01:54:44 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E1BDA8BB9A;
	Sun, 28 Dec 2008 01:54:43 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id F162A8BB97; Sun,
 28 Dec 2008 01:54:38 -0500 (EST)
In-Reply-To: <200812280312.02615.jnareb@gmail.com> (Jakub Narebski's message
 of "Sun, 28 Dec 2008 03:12:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 683A84BE-D4AC-11DD-A09F-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104043>

Jakub Narebski <jnareb@gmail.com> writes:

> On Sat, 27 Dec 2008, Devin Doucette wrote:
>
>> When $filter was empty, the path passed to check_export_ok would
>> contain an extra '/', which some implementations of export_auth_hook
>> are sensitive to.
>> 
>> It makes more sense to fix this here than to handle the special case
>> in each implementation of export_auth_hook.
>> 
>> Signed-off-by: Devin Doucette <devin@doucette.cc>
>
> Good catch. Thanks.

Thanks, both.  Will queue for 'maint'.
