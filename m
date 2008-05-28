From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem fetching the git homepage
Date: Wed, 28 May 2008 09:39:53 -0700
Message-ID: <7v1w3mwffq.fsf@gitster.siamese.dyndns.org>
References: <483D7E27.7030809@isy.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Gustaf Hendeby <hendeby@isy.liu.se>
X-From: git-owner@vger.kernel.org Wed May 28 18:41:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Ohv-00048w-W5
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 18:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbYE1QkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 12:40:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbYE1QkD
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 12:40:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47962 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751194AbYE1QkD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 12:40:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 771764440;
	Wed, 28 May 2008 12:40:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id B7A5843FF; Wed, 28 May 2008 12:39:57 -0400 (EDT)
In-Reply-To: <483D7E27.7030809@isy.liu.se> (Gustaf Hendeby's message of "Wed,
 28 May 2008 17:45:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: B78711FC-2CD4-11DD-B3F3-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83107>

Gustaf Hendeby <hendeby@isy.liu.se> writes:

> I'm trying to fetch the repo of the git homepage but get this error:
>
> $ git version
> git version 1.5.6.rc0.140.ga9675
> $ git fetch origin
> Getting alternates list for http://repo.or.cz/r/git-homepage.git
> Getting pack list for http://repo.or.cz/r/git-homepage.git
> Getting index for pack d4404a860edd30b154e8cd5b8c66ec35cf682dae
> Getting pack d4404a860edd30b154e8cd5b8c66ec35cf682dae
>  which contains 50819d376acb03429ab2628ef3d07893c7f0e22c
> error: packfile
> .git/objects/pack/pack-d4404a860edd30b154e8cd5b8c66ec35cf682dae.pack
> size changed
> fatal: packfile
> .git/objects/pack/pack-d4404a860edd30b154e8cd5b8c66ec35cf682dae.pack
> cannot be accessed
>
> The last commit I have is "Automated update: [2008-04-20] v1.5.5 ->
> v1.5.5.1" (2b7e2d6a).
>
> Is this due to something I've done?  (Not even sure from the error
> message if it is a local error, or a remote error.) Or a sign of
> something more serious?

Thanks for reporting.  This is a breakage in 633f43e (Remove redundant
code, eliminate one static variable, 2008-05-24).
