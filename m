From: Stefan Sperling <stsp@elego.de>
Subject: Re: [PATCH v2] Add svnrdump
Date: Wed, 14 Jul 2010 19:34:09 +0200
Message-ID: <20100714173409.GD25861@ted.stsp.name>
References: <20100709142910.GB20383@debian>
 <20100713201105.GN13310@ted.stsp.name>
 <20100714153206.GH25630@jack.stsp.name>
 <20100714160149.GA7561@debian>
 <20100714172429.GC25861@ted.stsp.name>
 <4C3DF456.20803@collab.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
        "dev@subversion.apache.org" <dev@subversion.apache.org>,
        Bert Huijben <rhuijben@collab.net>,
        Daniel Shahaf <d.s@daniel.shahaf.name>,
        Will Palmer <wmpalmer@gmail.com>,
        David Michael Barr <david.barr@cordelta.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Sverre Rabbelier <srabbelier@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
To: "C. Michael Pilato" <cmpilato@collab.net>
X-From: dev-return-5011-gcvsd-dev=m.gmane.org@subversion.apache.org Wed Jul 14 19:34:56 2010
Return-path: <dev-return-5011-gcvsd-dev=m.gmane.org@subversion.apache.org>
Envelope-to: gcvsd-dev@lo.gmane.org
Received: from hermes.apache.org ([140.211.11.3] helo=mail.apache.org)
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <dev-return-5011-gcvsd-dev=m.gmane.org@subversion.apache.org>)
	id 1OZ5rC-0005gp-D2
	for gcvsd-dev@lo.gmane.org; Wed, 14 Jul 2010 19:34:54 +0200
Received: (qmail 47703 invoked by uid 500); 14 Jul 2010 17:34:52 -0000
Mailing-List: contact dev-help@subversion.apache.org; run by ezmlm
Precedence: bulk
List-Help: <mailto:dev-help@subversion.apache.org>
List-Unsubscribe: <mailto:dev-unsubscribe@subversion.apache.org>
List-Post: <mailto:dev@subversion.apache.org>
List-Id: <dev.subversion.apache.org>
Delivered-To: mailing list dev@subversion.apache.org
Received: (qmail 47695 invoked by uid 99); 14 Jul 2010 17:34:52 -0000
Received: from nike.apache.org (HELO nike.apache.org) (192.87.106.230)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 14 Jul 2010 17:34:52 +0000
X-ASF-Spam-Status: No, hits=-0.7 required=10.0
	tests=RCVD_IN_DNSWL_LOW,SPF_PASS
X-Spam-Check-By: apache.org
Received-SPF: pass (nike.apache.org: local policy)
Received: from [192.109.42.8] (HELO einhorn.in-berlin.de) (192.109.42.8)
    by apache.org (qpsmtpd/0.29) with ESMTP; Wed, 14 Jul 2010 17:34:42 +0000
X-Envelope-From: stsp@stsp.name
Received: from ted.stsp.name (ted.stsp.name [217.197.84.186])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id o6EHYAAP025678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 14 Jul 2010 19:34:10 +0200
Received: from ted.stsp.name (stsp@localhost [127.0.0.1])
	by ted.stsp.name (8.14.3/8.14.3) with ESMTP id o6EHY9uP018556;
	Wed, 14 Jul 2010 19:34:09 +0200 (CEST)
Received: (from stsp@localhost)
	by ted.stsp.name (8.14.3/8.14.3/Submit) id o6EHY9MN008827;
	Wed, 14 Jul 2010 19:34:09 +0200 (CEST)
Mail-Followup-To: "C. Michael Pilato" <cmpilato@collab.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"dev@subversion.apache.org" <dev@subversion.apache.org>,
	Bert Huijben <rhuijben@collab.net>,
	Daniel Shahaf <d.s@daniel.shahaf.name>,
	Will Palmer <wmpalmer@gmail.com>,
	David Michael Barr <david.barr@cordelta.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C3DF456.20803@collab.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
X-Virus-Checked: Checked by ClamAV on apache.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151020>

On Wed, Jul 14, 2010 at 01:31:02PM -0400, C. Michael Pilato wrote:
> Revprops aren't handled by the replay API for any revision.

Ah, I didn't know that.
I was assuming they were transmitted via the replay API but I didn't check.

Thanks,
Stefan
