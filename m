From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: [Opinion gathering] Git remote whitelist/blacklist
Date: Tue, 24 May 2016 12:16:46 -0400
Message-ID: <002b01d1b5d7$aefd0a70$0cf71f50$@nexbridge.com>
References: <1040142021.5607762.1463753271105.JavaMail.zimbra@ensimag.grenoble-inp.fr> <584027154.5608416.1463754104066.JavaMail.zimbra@ensimag.grenoble-inp.fr> <001001d1b2a3$06d7bbb0$14873310$@nexbridge.com> <1929221963.5686879.1464007899902.JavaMail.zimbra@ensimag.grenoble-inp.fr> <1884904685.12056.1464084750628.JavaMail.zimbra@ensimag.grenoble-inp.fr> <84BDC4A4-FBE1-4542-868C-FA77A25469F3@gmail.com> <vpq37p74nu1.fsf@anie.imag.fr> <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: "'Lars Schneider'" <larsxschneider@gmail.com>,
	"'Francois Beutin'" <beutinf@ensimag.grenoble-inp.fr>,
	"'Git Mailing List'" <git@vger.kernel.org>,
	"'simon rabourg'" <simon.rabourg@ensimag.grenoble-inp.fr>,
	"'wiliam duclot'" <wiliam.duclot@ensimag.grenoble-inp.fr>,
	"'antoine queru'" <antoine.queru@ensimag.grenoble-inp.fr>
To: "'Junio C Hamano'" <gitster@pobox.com>,
	"'Matthieu Moy'" <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue May 24 18:17:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5F0z-0004ME-Jr
	for gcvg-git-2@plane.gmane.org; Tue, 24 May 2016 18:17:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752343AbcEXQRA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 May 2016 12:17:00 -0400
Received: from elephants.elehost.com ([216.66.27.132]:49679 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751435AbcEXQQ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 May 2016 12:16:59 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE00fc8d49d843-CM00fc8d49d840.cpe.net.cable.rogers.com [174.112.90.66])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id u4OGGrWt088041
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 24 May 2016 12:16:54 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <CAPc5daURo8SkbeGf0MEsp0sLzdzFfUOxptgusFr58UG9SKmDAA@mail.gmail.com>
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIL2Z0EoI8qcR9zrUX6F0hnJju9VgLJLMcyAaESwn4C9DPPywHjk1f3AhzO6WECQCA7aAFTJijBntxqCrA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295499>

On May 24, 2016 12:08 PM, Matthieu Moy wrote:
> > So, when trying a forbidden push, Git would deny it and the only way
> > to force the push would be to remove the blacklist from the config, right?
> >
> > Probably the sanest way to go. I thought about adding a "git push
> > --force-even-if-in-blacklist" or so, but I don't think the feature
> > deserves one specific option (hence add some noise in `git push -h`).
> 
> Yeah, I agree --even-if-in-blacklist is a road to madness, but I wonder how
> this is different from setting pushURL to /dev/null or something illegal and
> replace that phony configuration value when you really need to push?

May be missing the point, but isn't the original intent to provide policy-based to control the push destinations? A sufficiently knowledgeable person, being a couple of weeks into git, would easily see that the config points to a black-listed destination and easily bypass it with a config update, rendering all this pointless? This seems to me to be a lot of effort to go to for limited value - unless immutable attributes are going to be obtained from the upstream repository - which also seems to run counter to the whole point.

Confusededly,
Randall
