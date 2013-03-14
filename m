From: Michal Novotny <minovotn@redhat.com>
Subject: Re: [PATCH v2] git-tag: Allow --points-at syntax to create a tag
 pointing to specified commit
Date: Thu, 14 Mar 2013 15:36:06 +0100
Message-ID: <5141E056.3090808@redhat.com>
References: <4150f65f3e425d6120ed80c6bec36c1fe209a876.1363264398.git.minovotn@redhat.com> <20130314133629.GA4256@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Thu Mar 14 15:36:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UG9Gp-00089G-1l
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 15:36:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756917Ab3CNOgM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Mar 2013 10:36:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30464 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756123Ab3CNOgL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Mar 2013 10:36:11 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id r2EEa8mq028149
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Thu, 14 Mar 2013 10:36:08 -0400
Received: from miglaptop.brq.redhat.com (dhcp-1-114.brq.redhat.com [10.34.1.114])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id r2EEa6oQ018541;
	Thu, 14 Mar 2013 10:36:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130219 Thunderbird/17.0.3
In-Reply-To: <20130314133629.GA4256@serenity.lan>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.24
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218139>


On 03/14/2013 02:36 PM, John Keeping wrote:
> On Thu, Mar 14, 2013 at 01:34:54PM +0100, Michal Novotny wrote:
>> This patch adds the option to specify SHA-1 commit hash using --points-at
>> option of git tag to create a tag pointing to a historical commit.
> What does this do that "git tag <name> <commit>" doesn't?

Oh, interesting. It's working now and I didn't know that as it was not
working some time ago I've been trying this approach. Maybe it's been
added recently as I also saw several sites having different approach of
tagging to specified commit (usually creating a new branch, tagging
there and rebasing etc.).

Thanks for information!
Michal

-- 
Michal Novotny <minovotn@redhat.com>, RHCE, Red Hat
Virtualization | libvirt-php bindings | php-virt-control.org
