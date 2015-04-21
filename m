From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v8 2/4] cat-file: teach cat-file a '--literally' option
Date: Tue, 21 Apr 2015 11:16:42 +0100
Message-ID: <20150421101641.GA13202@hashpling.org>
References: <552E9816.6040502@gmail.com>
 <1429117174-4968-1-git-send-email-karthik.188@gmail.com>
 <20150419002807.GA11634@hashpling.org>
 <xmqq7ft7nz8l.fsf@gitster.dls.corp.google.com>
 <20150420074433.GA30422@hashpling.org>
 <8CBC4DEB-EC50-4DD7-A687-443AA93A96A8@gmail.com>
 <20150420091920.GA31279@hashpling.org>
 <553520CF.6070304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"sunshine@sunshineco.com" <sunshine@sunshineco.com>
To: karthik nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 12:17:09 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkVEr-0005lx-1L
	for gcvg-git-2@plane.gmane.org; Tue, 21 Apr 2015 12:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbbDUKRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2015 06:17:03 -0400
Received: from avasout05.plus.net ([84.93.230.250]:39746 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751473AbbDUKRB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2015 06:17:01 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id JaGi1q0022iA9hg01aGjmZ; Tue, 21 Apr 2015 11:16:58 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=O8+3vXNW c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=e9J7MTPGsLIA:10 a=5UmqNcqcavSDM6RW50wA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1YkVEQ-0003SL-5X; Tue, 21 Apr 2015 11:16:42 +0100
Content-Disposition: inline
In-Reply-To: <553520CF.6070304@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267522>

On Mon, Apr 20, 2015 at 09:22:47PM +0530, karthik nayak wrote:
> 
> 
> On 04/20/2015 02:49 PM, Charles Bailey wrote:
> >As far as I could tell - and please correct me if I've misunderstood,
> >cat-file's literally is about dealing with unrecognized types whereas
> >hash-object's --literally is about both creating objects with bad types
> >and invalid objects of "recognized" types. This latter scenario is where
> >the option name "literally" makes the most sense.
> Yes. What you're saying is correct, but it also makes sense as we're asking
> "cat-file" to give us information about the object irrespective of the type of the
> object, hence asking it to literally print the information. Also it stays as a compliment
> to "hash-object --literally", which is already existing.

OK, I think you've hit the main point which I was trying to make.

To me, "literally" means "without transformation" or "exactly as
written/recorded/transmitted" (which -t/-s do anyway) and doesn't really
encompass the "irrespective of type" meaning that it has been given here.

In any case, I've made my point so I won't labour it any further. I
think that --no-validation or --allow-any-type might be more accurate
but if everyone else is happy enough with --literally then I'm happy to
live with that too.
