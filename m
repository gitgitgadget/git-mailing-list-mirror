From: Josh Stone <jistone@redhat.com>
Subject: Re: [PATCH] blame: Improve parsing for emails with spaces
Date: Fri, 29 Apr 2011 11:17:48 -0700
Message-ID: <4DBB00CC.3030400@redhat.com>
References: <1303423656-32002-1-git-send-email-jistone@redhat.com> <20110429131103.GB4540@sigill.intra.peff.net> <7vvcxxvsz4.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 20:18:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFsGR-0008N1-UR
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 20:18:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760809Ab1D2SR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 14:17:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36385 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760760Ab1D2SR5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 14:17:57 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3TIHnwf032521
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Fri, 29 Apr 2011 14:17:49 -0400
Received: from [10.3.113.77] (ovpn-113-77.phx2.redhat.com [10.3.113.77])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id p3TIHmA3019536;
	Fri, 29 Apr 2011 14:17:49 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110307 Fedora/3.1.9-0.39.b3pre.fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vvcxxvsz4.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang 2.68 on 10.5.11.22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172486>

On 04/29/2011 10:59 AM, Junio C Hamano wrote:
> It would be an entirely different issue if the command barfed and refused
> to blame the file.

Yeah - the command doesn't fail outright.  Anything that builds on
blame/annotate would get bad data, but for me it's more of a formatting
issue.  In my actual bad commit, the author's "name <broken email" takes
up 61 characters, making the whole blame output tediously wide.

Thanks for taking the patch.

Josh
