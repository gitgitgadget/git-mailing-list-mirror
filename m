From: Tomas Carnecky <tom@dbservice.com>
Subject: Re: [RFC PATCH] Introduce git-hive
Date: Sun, 05 Sep 2010 22:08:46 +0200
Message-ID: <4C83F8CE.2060403@dbservice.com>
References: <1283198367-11440-1-git-send-email-cdahlin@redhat.com> <AANLkTikcV6f=bUBa-F44JCEFOT0dHrvgrLY-j9hvvOyX@mail.gmail.com> <AANLkTinx_Y1iUt9tj4io=GskwRyvK2EdWv9cO9gAbxBS@mail.gmail.com> <20100831143839.GC16034@foucault.redhat.com> <AANLkTinF1o0RZSKYEL9Qc=uwXx6fBBXh6wRx2CTULBSE@mail.gmail.com> <20100831155159.GD16034@foucault.redhat.com> <815C806E-E7DC-4B7D-9B45-4C9B289DFEEF@sb.org> <20100831191909.GF16034@foucault.redhat.com> <9CA6AC3D-5C51-4770-BF78-077DE5CD80C5@sb.org> <20100831192539.GG16034@foucault.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Kevin Ballard <kevin@sb.org>,
	Luke Kenneth Casson Leighton <luke.leighton@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git <git@vger.kernel.org>
To: Casey Dahlin <cdahlin@redhat.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 22:09:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsLWd-0005BZ-Ly
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 22:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754489Ab0IEUJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 16:09:09 -0400
Received: from office.neopsis.com ([78.46.209.98]:41307 "EHLO
	office.neopsis.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab0IEUJI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 16:09:08 -0400
X-Spam-Status: No, hits=0.0 required=5.0
	tests=AWL: 0.061,BAYES_00: -1.665,TOTAL_SCORE: -1.604,autolearn=ham
X-Spam-Level: 
Received: from calvin.caurea.org ([62.65.141.13])
	(authenticated user tom@dbservice.com)
	by office.neopsis.com
	(using TLSv1/SSLv3 with cipher AES256-SHA (256 bits));
	Sun, 5 Sep 2010 22:08:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <20100831192539.GG16034@foucault.redhat.com>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155482>

On 8/31/10 9:25 PM, Casey Dahlin wrote:
> Not sure Avahi will be used at all at this point given present objections. Its

Which objections?

> hard because although its the same protocol, I believe the api is different, so
> we'd need additional code. I don't think bundling Avahi on OSX is the right
> answer to anything regardless.

You can code against the mDNSResponder API and on Linux use the Avahi
mDNSResponder compatibility layer.

tom
